require 'spec_helper'

describe IndianRail::Schedule do
	describe "Enquiry:" do 
		it "Should not accept blank train" do		
			IndianRail::Schedule.find.should include(:message => "Please Enter Train Number or Name")			
		end
		
		it "Should return results" do
			resp = IndianRail::Schedule.find("12738", proxy: {url: 'proxy.cognizant.com', port: 6050}) #.should have_key(:train_details)
			puts resp.inspect
		end
	end	
end