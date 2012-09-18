require 'spec_helper'

describe Topic do
  describe "Validations" do
    before(:each) do
      @topic = FactoryGirl.build(:topic)
    end
    
    [:title, :description, :user_id].each do |attr|
      it "should be invalid without #{attr}" do
				@topic.send("#{attr}=", nil)
				@topic.should have(1).errors_on(attr)
			end
    end
  end
end
