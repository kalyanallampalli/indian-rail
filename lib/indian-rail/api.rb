require 'rubygems'
require 'uri'
require 'nokogiri'
require 'net/http'

module IndianRail
	class Api
		class << self			
			def get_response(url, options={})				
				response, uri = '', URI.parse(url)
				options = Hash[options.map{|(k,v)| [k.to_sym,v]}]
				net_http = if options.has_key?(:proxy)
					options[:proxy][:url] = URI.parse(options[:proxy][:url].gsub('www.', '')).host if options[:proxy][:url].include?('http://')
					Net::HTTP::Proxy(options[:proxy][:url], options[:proxy][:port])
				else
					Net::HTTP
				end						
				net_http.start(uri.host, uri.port) do |http|				
					request = Net::HTTP::Post.new(uri.request_uri)
					request.set_form_data(options[:form_params])
					request['referer'] = options[:referer] if options.has_key?(:referer)					
					response = http.request(request).body									
				end											
				response
			end
			
			def base_url_prefix
				@base_url ||= "http://www.indianrail.gov.in/cgi_bin"
			end
			
			def pnr_url_sufix
				@pnr_url ||= "inet_pnrstat_cgi.cgi"
			end

			def schedule_url_sufix
				@schedule ||= "inet_trnnum_cgi.cgi"
			end			
		end	
	end
end