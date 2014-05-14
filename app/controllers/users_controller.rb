class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user
  before_filter :get_user

  def edit
    cookies['not_new'] = ''
    if @user.stripe_token
      @customer = Stripe::Customer.retrieve(@user.stripe_token)
      @subscription = @customer.subscriptions.first
      if @subscription
        @end_time = DateTime.strptime(@subscription.current_period_end.to_s, "%s")
      end
      @card = @customer.cards.first
    end
  end

  def update
    if @user.update(user_params)
      if @user.email_was == nil and @user.email_changed?
        FilterMailer.gave_email(@user.email)
      end
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
    @correct_user = User.find_by_id(params[:id])
    if @correct_user.nil? || current_user != @correct_user
      redirect_to root_path, alert: "You are not permitted to access this page."
    end
  end
end
