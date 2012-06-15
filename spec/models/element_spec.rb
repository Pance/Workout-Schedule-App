require 'spec_helper'

describe Element do
	before do
		@element = Element.new(:schedule_id => 2)
	end

	subject { @element }
	
	it { should respond_to(:schedule_id) }

	it { should be_valid }

	describe "when schedule_id is not present" do
		before { @element.schedule_id = nil }
		it { should_not be_valid }
	end
end
