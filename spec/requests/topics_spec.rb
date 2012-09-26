require 'spec_helper'

describe "Topics" do
  describe "logged in" do
    describe "user" do
      before :each do
        @user = FactoryGirl.create(:user)
        @topic = FactoryGirl.create(:topic)
        login @user
      end
      
      describe "on topic page" do
        before :each do
          visit topic_path(@topic)
        end
        
        it "doesn't see Edit and Destroy topic buttons" do
          page.should have_no_css(".edit-topic")
          page.should have_no_css(".destroy-topic")
        end
        
        it "upvotes Topic" do
          find(:xpath, '//div[@class="up vote"]/a').click
          current_path.should == topic_path(@topic)
          find(:css, ".score").should have_content("1")
        end
        
        it "downvotes Topic" do
          find(:xpath, '//div[@class="down vote"]/a').click
          current_path.should == topic_path(@topic)
          find(:css, ".score").should have_content("-1")
        end
        
        it "sees no poll votes for topic if no votes have been made" do
          page.should have_content("No votes yet")
        end
        
        it "upvotes poll" do
          find(:css, "#yes-vote").click
          page.should have_content("Yes (100 %)")
        end
        
        it "downvotes poll" do
          find(:css, "#no-vote").click
          page.should have_content("No (100 %)")
        end
      end
      
      describe "on landing page" do
        before :each do
          visit root_path
        end
      
        it "upvotes topic" do
          find(:xpath, '//div[@class="up vote"]/a').click
          current_url.should == topic_url(@topic)
          find(:css, ".score").should have_content "1"
        end
    
        it "downvotes topic" do        
          find(:xpath, '//div[@class="down vote"]/a').click
          current_url.should == topic_url(@topic)
          find(:css, ".score").should have_content "-1"
        end
        
        it "creates new topic" do
          click_link "New"
          current_url.should == new_topic_url
          @new_topic = FactoryGirl.build(:topic)
          fill_in "Title", :with => @new_topic.title
          fill_in "Description", :with => @new_topic.description
          click_on "Create Topic"
          current_url.should == topic_url(Topic.last.id)
          page.should have_content(@new_topic.title)
          page.should have_content("Topic was successfully created.")
        end
        
        it "fails creating new topic" do
          click_link "New"
          current_url.should == new_topic_url
          @new_topic = FactoryGirl.build(:topic, :title => nil)
          fill_in "Title", :with => @new_topic.title
          fill_in "Description", :with => @new_topic.description
          click_on "Create Topic"
          page.should have_content("can't be blank")
        end
        
        it "doesn't see Edit and Destroy topic buttons" do
          visit root_path
          page.should have_no_css(".edit-topic")
          page.should have_no_css(".destroy-topic")
        end
      end
    
      it "cannot access edit_topic_path" do
        visit edit_topic_path(@topic)
        page.should have_content("You are not authorized to access this page.")
        current_url.should == root_url
      end
    end
    
    describe "admin" do
      before :each do
        @topic = FactoryGirl.create(:topic)
        @admin = FactoryGirl.create(:admin)
        login @admin
      end
      
      describe "on landing page" do
        it "sees Edit or Destroy buttons" do
          visit root_path
          page.should have_css(".edit-topic")
          page.should have_css(".destroy-topic")
        end
    
        it "edits topic" do
          visit root_path
          find(:css, ".edit-topic").click
          current_url.should == edit_topic_url(@topic)
          fill_in "Title", :with => "Foobar"
          fill_in "Description", :with => "The Description"
          click_button "Update Topic"
          page.should have_content("Topic was successfully updated.")
          current_url.should == topic_url(@topic)
          page.should have_content("The Description")
          find(:css, "h1").should have_content("Foobar")
        end
        
        it "fails editing topic" do
          visit root_path
          find(:css, ".edit-topic").click
          current_url.should == edit_topic_url(@topic)
          fill_in "Title", :with => ""
          fill_in "Description", :with => "The Description"
          click_button "Update Topic"
          page.should have_content("can't be blank")
        end
    
        it "deletes topic" do
          visit root_path
          find(:css, ".destroy-topic").click
          page.should have_content("Topic was successfully deleted.")
          current_url.should == root_url
          page.should have_no_content(@topic.title)
        end
      end
    
      describe "on topic page" do
        before :each do
          visit topic_path(@topic)
        end
        
        it "sees Edit or Destroy buttons" do
          page.should have_css(".edit-topic")
          page.should have_css(".destroy-topic")
        end
      end
    end
  end
  
  describe "not logged in user" do
    before :each do
      @topic = FactoryGirl.create(:topic)
    end
    
    describe "on landing page" do
      it "sees topics" do
        @topics = Array.new
        5.times do
          @topics << FactoryGirl.create(:topic)
        end
        visit root_path
        @topics.each do |topic|
          page.should have_content(topic.title)
        end
      end
    
      it "tries to create new topic" do
        visit root_path
        within(:css, "#main") do
          click_link "New"
        end
        current_url.should == new_user_session_url
        page.should have_content "You need to sign in or sign up before continuing."
      end
    
      it "doesn't see Edit and Destroy topic buttons" do
        visit root_path
        page.should have_no_css(".edit-topic")
        page.should have_no_css(".destroy-topic")
      end
      
      it "can view topic" do
        visit topic_path(@topic)
        page.should have_content(@topic.title)
      end
    end
  end
end
