require "retrieved_coupon"

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
      redirect_to my_podcast_path, notice: "Your upgraded account has been reinstated! Thanks for using Filter!"
    else
      redirect_to edit_user_path(current_user), alert: "You do not have a current subscription."
    end
  end

  def validate_coupon
    if params[:coupon]
      begin
        @retrieved_coupon = Stripe::Coupon.retrieve(params[:coupon])
        @coupon = RetrievedCoupon.new(@retrieved_coupon)
      rescue Stripe::InvalidRequestError => e
        @coupon = nil
      end
      if @coupon
        resp = { response: @coupon.text, new_price: @coupon.new_price }
        render json: resp, status: :ok
      else
        resp = { response: '' }
        render json: resp, status: :ok
      end
    end
  end

  def create
    # Amount in cents
    if current_user.stripe_token
      reactivate
    else
      @customer = Stripe::Customer.create(
        email: current_user.email,
        card:  params[:stripe_token],
        plan:  1,
        coupon: params[:coupon],
      )
      @subscription = @customer.subscriptions.first
      @subscribed_at = parse_stripe_time(@subscription.start)
      @trial_end = parse_stripe_time(@subscription.current_period_end)
      current_user.update(
        subscribed: true,
        subscribed_at: @subscribed_at,
        trial_ends_at: @trial_end,
        stripe_token: @customer.id
      )
      redirect_to my_podcast_path, notice: "Your account has been upgraded! Thanks for using Filter!"
    end

  rescue Stripe::CardError => e
    redirect_to new_subscription_path, alert: e.message
  end

  def destroy
    @customer = Stripe::Customer.retrieve(current_user.stripe_token)
    @customer.cancel_subscription
    current_user.update(subscribed: false)
    redirect_to my_podcast_path, alert: "Your subscription has been canceled. Thanks for using Filter!"
  end

  private
  def parse_stripe_time(time)
    DateTime.strptime(time.to_s, '%s')
  end
end
