class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user
  before_filter :get_user

  def edit
    @customer = Stripe::Customer.retrieve(current_user.stripe_token)
    @subscription = @customer.subscription
    if @subscription.current_period_end == @subscription.trial_end
      @on_trial = true
    end
    @end_time = DateTime.strptime(@subscription.current_period_end.to_s, "%s")
    @card = @customer.cards.first
  end

  def update
    if @user.update(user_params)
      redirect_to my_podcast_path, notice: "Your profile has been updated."
    end
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end

  def get_user
    @user = current_user
  end

  def correct_user
    @correct_user = User.find params[:id]
    if current_user != @correct_user or @correct_user.nil?
      redirect_to root_path, alert: "You are not permitted to access this page."
    end
  end
end
