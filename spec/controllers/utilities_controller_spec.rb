require 'spec_helper'

describe UtilitiesController do
  describe "GET #hello" do
    it "responds successfully with an HTTP 200 status code and a hello" do
      get :hello
      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(response.body).to include("Hello! Filter reporting for duty.")
    end
  end
end
