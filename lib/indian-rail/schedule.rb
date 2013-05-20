module IndianRail
	class Schedule < Api		
		def self.find(train_no=nil, options={})
			response = {}
			response[:message] = 'Please Enter Train Number or Name' and return response if train_no.nil?			
			begin
				page_response = get_response([base_url_prefix, schedule_url_sufix].compact.join("/"), {:form_params => {'lccp_trnname' => train_no}}.merge!(options))	
				response = parse_train_details(page_response, train_no)
			rescue Exception => e				
				response[:message] = "Service is not available - #{e.message}"
			end
			response
		end
		
		private		
		
		def self.parse_train_details(body, train_no)
			page = Nokogiri::HTML(body)			
			tables = page.xpath('//table[@class="table_border_both"]')
			details, train_detail = {}, {}
			if tables.length == 3
				runs_on = []
				index = 1
				coach_details, stn_details = [], [['Stn Code', 'Stn Name', 'Route No.', 'Arrival Time', 'Dep. time', 'Halt Time(In Min))', 'Distance', 'Day']]
				tables.collect do |table|
					if index == 1						
						table.css("tr:not([@class='heading_table_top'])").collect do |row|								
							[
								[:train_no, 'td[1]/text()'],
								[:train_name, 'td[2]/text()'],
								[:runs_from, 'td[3]/text()']
							].each do |name, xpath|
								train_detail[name] = row.at_xpath(xpath).to_s.strip
							end						
							(4..10).each do |day|
								runs_on << row.at_xpath("td[#{day}]/text()").to_s.strip
							end		
							train_detail[:runs_on] = runs_on.join(', ')						
						end
					elsif index == 2
						table.css("tr:not([@class='heading_table_top'])").collect do |row|	
							coach_detail = {}
							[
								[:title, 'td[1]/text()'],
								['1A', 'td[2]/text()'],
								['2A', 'td[3]/text()'],
								['FC', 'td[4]/text()'],
								['3A', 'td[5]/text()'],
								['CC', 'td[6]/text()'],
								['SL', 'td[7]/text()'],
								['2S', 'td[8]/text()'],
								['3E', 'td[9]/text()']
							].each do |name, xpath|
								coach_detail[name] = row.at_xpath(xpath).to_s.strip
							end
							coach_details << coach_detail
						end
					elsif index == 3
						table.css("tr:not([@class='heading_table_top'])").collect do |row|	
							stn_detail = []
							['td[2]/text()', 'td[3]/text()', 'td[4]/text()', 'td[5]/text()', 'td[6]/text()', 'td[7]/text()', 'td[8]/text()','td[9]/text()'].each do |xpath|
								stn_detail << row.at_xpath(xpath).to_s.strip
							end						
							stn_details << stn_detail
						end						
					end	
					index += 1
				end				
				details[:train_details] = train_detail
				details[:coach_details] = coach_details
				details[:stn_details] = stn_details
			else
				stn_details = [['Train Number', 'Train Name', 'Train Source', 'Dep.Time', 'Train Destination', 'Arr.Time']]	
				tables.collect do |table|
					table.css("tr:not([@class='heading_table_top'])").collect do |row|					
						train_detail = []				
						['td[1]/input', 'td[2]/text()', 'td[3]/text()', 'td[4]/text()', 'td[5]/text()', 'td[6]/text()'].each_with_index do |xpath, i|
							train_detail << (i == 0 ? row.at(xpath)['value'].to_i : row.at_xpath(xpath).to_s.strip)						
						end						
						stn_details << train_detail
					end
				end
				details[:train_details] = stn_details.length == 1 ? 'Invalid Train name or data not exists' : details					
			end
			details			
		end	
	end
end