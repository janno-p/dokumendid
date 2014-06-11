# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

require "rails_helper"

describe SessionController do
  describe "GET #sign_in" do
    it "responds successfully with an HTTP 200 status code" do
      get :sign_in
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the sing_in template" do
      get :sign_in
      expect(response).to render_template("sign_in")
    end
  end

  describe "GET #sign_out" do
    it "unauthenticated request responds with redirect to sign_in path" do
      get :sign_out
      expect(response.status).to eq(302)
      expect(response).to redirect_to sign_in_path
      expect(flash[:notice]).to eq("Palun logi sisse")
    end
  end
end
