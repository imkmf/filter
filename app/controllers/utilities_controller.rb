class UtilitiesController < ApplicationController
  respond_to :html, :json

  def hello
    @string = "Hello! Filter reporting for duty."
    render json: { status: @string }, status: :ok
  end
end
