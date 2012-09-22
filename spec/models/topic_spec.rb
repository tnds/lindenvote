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
  
  describe "Votes" do
    before(:each) do
      @topic = FactoryGirl.create(:topic)
      @user = FactoryGirl.create(:user)
    end
    
    it "should be negative when one user downvotes" do
      @topic.vote :voter => @user, :vote => "bad"
      score = @topic.upvotes.size - @topic.downvotes.size
      score.should == -1
    end
    
    it "should be positive when one user upvotes" do
      @topic.vote :voter => @user
      score = @topic.upvotes.size - @topic.downvotes.size
      score.should == 1
    end
    
    it "should be zero when one user upvotes and another user downvotes" do
      @user2 = FactoryGirl.create(:user)
      @topic.vote :voter => @user
      @topic.vote :voter => @user2, :vote => "bad"
      score = @topic.upvotes.size - @topic.downvotes.size
      score.should == 0
    end
  end
end
