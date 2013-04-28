require 'spec_helper'

describe IndianRail do
	it "Version must be defined" do
		IndianRail::VERSION.should_not be_empty
	end
end