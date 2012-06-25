require 'spec_helper'

describe PagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end
  
  #describe "home page" do
  
  #  let(:user) { FactoryGirl.create(:user) }
  
   # it "should have the user's email" do    
   #   visit '/'
   #   .should have_selector('h1', text: user.email)
  #  end
  #end
end
