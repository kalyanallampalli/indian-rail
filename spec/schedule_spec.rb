require 'spec_helper'

describe IndianRail::Schedule do
	describe "Enquiry:" do 
		it "Should not accept blank train" do		
			IndianRail::Schedule.find.should include(:message => "Please Enter Train Number or Name")			
		end
		
		it "Train name input should return results" do
			IndianRail::Schedule.find("ratnachal").should have_key(:train_details)						
		end
		
		it "Train number input should return results" do
			IndianRail::Schedule.find(11028).should have_key(:train_details)
		end
	end	
end