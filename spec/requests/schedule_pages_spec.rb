require 'spec_helper'

describe "SchedulePages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }
	
	describe "schedule creation" do
		before { visit root_path }

		describe "with valid information" do
			it "should create a schedule" do
				expect { click_button "Add Schedule Item" }.should change(Schedule, :count).by(1)
			end
		end
	end

	describe "schedule desctruction" do
		before { FactoryGirl.create(:schedule, user: user) }

		describe "as correct user" do
			before { visit root_path }

			it "should delete a schedule" do
				expect { click_link "delete" }.should change(Schedule, :count).by(-1)
			end
		end
	end
end
