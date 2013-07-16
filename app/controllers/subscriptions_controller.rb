class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def new
    if current_user.subscribed
      redirect_to my_podcast_path, alert: "You have already upgraded your account."
    elsif current_user.email.nil?
      redirect_to edit_user_path(current_user), alert: "You must set your email address to upgrade your account."
    end
  end

  def reactivate
    if current_user.stripe_token
      @customer = Stripe::Customer.retrieve(current_user.stripe_token)
      @customer.update_subscription(plan: 1)
      current_user.update(subscribed: true)
      redirect_to my_podcast_path, success: "Your upgraded account has been reinstated! Thanks for using Filter!"
    else
      redirect_to edit_user_path(current_user), alert: "You do not have a current subscription."
    end
  end

  def create
    # Amount in cents
    @amount = 800

    @customer = Stripe::Customer.create(
      email: current_user.email,
      card:  params[:stripeToken],
      plan:  1,
    )
    current_user.update(subscribed: true, stripe_token: @customer.id)
    redirect_to my_podcast_path, success: "Your account has been upgraded! Thanks for using Filter!"

  rescue Stripe::CardError => e
    redirect_to subscription_path, error: e.message
  end

  def destroy
    @customer = Stripe::Customer.retrieve(current_user.stripe_token)
    @customer.cancel_subscription
    current_user.update(subscribed: false)
    redirect_to my_podcast_path, alert: "Your subscription has been canceled. Thanks for using Filter!"
  end
end
