require 'spec_helper'

describe User do

	before { @user =  User.new(name: "Example User", email: "user@example.com",
														 password: "foobar") }

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:schedules) }
	it { should respond_to(:schedule_list) }
	it { should respond_to(:remember_token) }

	it { should be_valid }

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = " " }
		it { should_not be_valid }
	end

	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should be_invalid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_email(@user.email) }

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end

	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end
	
	describe "schedule associations" do

		before { @user.save }
		let!(:older_schedule) do
			FactoryGirl.create(:schedule, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_schedule) do
			FactoryGirl.create(:schedule, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right schedules in the right order" do
			@user.schedules.should == [older_schedule, newer_schedule]
		end

		it "should destroy associated schedules" do
			schedules = @user.schedules
			@user.destroy
			schedules.each do |schedule|
				Schedule.find_by_id(schedule.id).should be_nil
			end
		end

		describe "status" do
			let(:other_schedule) do
				FactoryGirl.create(:schedule, user: FactoryGirl.create(:user))
			end

			its(:schedule_list) { should include(newer_schedule) }
			its(:schedule_list) { should include(older_schedule) }
			its(:schedule_list) { should_not include(other_schedule) }
		end
	end
end
