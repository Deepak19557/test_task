class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def credit_limit_formula
    credit_limit = maximum_possible_emi * term_in_months
    maximum_possible_emi = (monthly_recurring_inflow/2 - monthly_recurring_outlfow)
  end

  def credibility_score
    debugger
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
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
