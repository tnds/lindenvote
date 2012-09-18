require 'spec_helper'

describe User do
  describe "Validations" do
    before(:each) do
      @user = FactoryGirl.build(:user)
    end
    
    [:email, :password, :username].each do |attr|
      it "should be invalid without #{attr}" do
				@user.send("#{attr}=", nil)
				@user.should have(1).errors_on(attr)
			end
    end
  end
end
