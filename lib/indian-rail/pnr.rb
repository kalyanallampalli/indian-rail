module IndianRail
	class Pnr < Api
		def self.enquiry(pnr=nil, options={})
			response = {}
			response[:message] = 'Please Enter PNR' and return response if pnr.nil?		
							
			begin
				page_response = get_response([base_url_prefix, pnr_url_sufix].compact.join("/"), 
							{:form_params => {'lccp_pnrno1' => pnr}, 
							:referer => 'http://www.indianrail.gov.in/pnr_stat.html'}.merge!(options))
				response = parse_page(page_response, pnr)							
			rescue Exception => e				
				response[:message] = "Service is not available - #{e.message}"
			end
			response
		end
			
		private
		
		# Crawling the response page and scraping the content
		def self.parse_page(body, pnr)				
			page = Nokogiri::HTML(body)
			data = {:pnr => pnr}	
			rows = [:train_no, :train_name, :boarding_date, :from, :to, :reserved_upto, :boarding_point, :class]
			pass_rows = [:sno, :booking_status, :current_status, :coach_position]
			passenger_list, list, i = {}, [], 0	
			page.css('//table[class="table_border"]/tr/td[class="table_border_both"]').each_with_index do |row, index|
				data[rows[index]] = row.text.gsub('*', '').strip if index <= 7
				if index > 7
					row.text.strip.downcase.match('passenger') ? (passenger_list = {}; i=0;) : (i += 1)
					i = -1 if row.text.strip if row.text.strip.upcase.match('CHART')
					passenger_list[pass_rows[i]] = row.text.strip if i <= 3 && i >= 0
					list << passenger_list if i == 2
					data[:charting_status] = row.text.strip if i == -1
				end
			end

			data[:passenger_list] = list unless list.empty?	
			data[:message] = 'FLUSHED PNR / PNR NOT YET GENERATED' if list.empty?			
			data			
		end
	end
end