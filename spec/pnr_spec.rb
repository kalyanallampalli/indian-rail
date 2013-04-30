require 'spec_helper'

describe IndianRail::Pnr do
	describe "Enquiry:" do 
		it "Should not accept blank pnr" do
			IndianRail::Pnr.enquiry.should include(message: "Please Enter PNR")			
		end
		
		it "Should return results" do
			response = IndianRail::Pnr.enquiry "2342423423"
		end
	end	
end