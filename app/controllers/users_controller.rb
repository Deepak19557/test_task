class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def credit_limit_formula
    maximum_possible_emi = ((User.last.money_inflow_in_account).to_i/2 - (User.last.money_outflow_in_account).to_i)
    if maximum_possible_emi > 0 and maximum_possible_emi < 5000
    term_in_months = 6 
    elsif maximum_possible_emi > 5001 and maximum_possible_emi < 10000
      term_in_months = 12
    elsif maximum_possible_emi > 10001 and maximum_possible_emi < 20000
      term_in_months = 18
    elsif maximum_possible_emi > 20000
      term_in_months = 24
    end

    @credit_limit = maximum_possible_emi * term_in_months

    if User.last.score.to_i > 2
      @message = "Your loan is accepted"
    else
      @message = "your loan is rejected"
    end
  end


  def create
    @user = User.new(user_params)
    score = params[:user][:facebook].to_i + params[:user][:linkedin].to_i + params[:user][:twitter].to_i + params[:user][:already_loan].to_i
    @user.score = score
    if @user.save
      redirect_to credit_limit_formula_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:email, :user_pan_card, :user_adhar_number, :bank_account_number, :bank_account_ifsc, :money_inflow_in_account, :money_outflow_in_account)
    end
end
