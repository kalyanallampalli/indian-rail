require 'spec_helper'

describe IndianRail::Schedule do
	describe "Enquiry:" do 
		it "Should not accept blank train" do		
			IndianRail::Schedule.find.should include(:message => "Please Enter Train Number or Name")			
		end
		
		it "Should return results" do
			IndianRail::Schedule.find(12727).should have_key(:train_details)
		end
	end	
end