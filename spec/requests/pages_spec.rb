require 'spec_helper'

describe "Pages" do

  describe "Home page" do

    describe "for non-signed-in users" do    
      let(:user) { FactoryGirl.create(:user) }
            
      it "should have the content 'Welcome to the Workout Randomizer App'" do
        visit '/'
        page.should have_content('Welcome to the Workout Randomizer App')
      end
    end
    
    describe "for signed-in users" do    
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit '/'
      end
      
      it "should have the user's email" do
        page.should have_selector('h1', :text => user.email)
      end
      
      #TODO add tests for schedules and elements
      
    end
  end
end
