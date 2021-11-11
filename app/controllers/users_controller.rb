class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def result
    @credit_limit = User.last.credit_limit
    @message = User.last.score.to_i > 2 ? "Your loan is approved" : "Your loan request is rejected because your credibility is less than 2"
  end

  def create
    @user = User.new(user_params)
    score = params[:user][:facebook].to_i + params[:user][:linkedin].to_i + params[:user][:twitter].to_i + params[:user][:already_loan].to_i
    @user.score = score
    credit_limit = credit_limit_formula params[:user][:money_inflow_in_account] ,params[:user][:money_outflow_in_account]
    @user.credit_limit = credit_limit
    if @user.save
      redirect_to result_path
    else
      render :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:email, :user_pan_card, :user_adhar_number, :bank_account_number, :bank_account_ifsc, :money_inflow_in_account, :money_outflow_in_account)
  end

  def credit_limit_formula  money_inflow_in_account , money_outflow_in_account
    maximum_possible_emi = ((money_inflow_in_account).to_i/2 - (money_outflow_in_account).to_i)
    if maximum_possible_emi >= 0 and maximum_possible_emi < 5000
    term_in_months = 6
    elsif maximum_possible_emi > 5001 and maximum_possible_emi < 10000
      term_in_months = 12
    elsif maximum_possible_emi > 10001 and maximum_possible_emi < 20000
      term_in_months = 18
    elsif maximum_possible_emi > 20000
      term_in_months = 24
    end
    credit_limit = maximum_possible_emi * term_in_months
    return credit_limit
  end
end
