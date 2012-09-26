require 'spec_helper'

describe Argument do
  describe "Validations" do
    before(:each) do
      @argument = FactoryGirl.build(:argument)
      
    end
    
    [:title, :description, :sort, :topic_id, :user_id].each do |attr|
      it "should be invalid without #{attr}" do
				@argument.send("#{attr}=", nil)
				@argument.should have_at_least(1).error_on(attr)
			end
    end
    
    it "should be invalid with a wrong argument type" do
      @argument.send("sort=", "Foo")
			@argument.should have_at_least(1).error_on(:sort)
    end
  end
  
  describe "Custom methods" do
    before(:each) do
      @argument = FactoryGirl.build(:pro_argument)
    end
    
    it "has a score" do
      @argument.score.should == 0
    end
  end
end
