require 'spec_helper'

describe "Authentications" do
  describe "Login" do
    it "logs user in" do
      @user = FactoryGirl.create(:user)
      login @user
      page.should have_content("Signed in successfully.")
    end
  end
end
