class Calender < ActiveRecord::Base
	require 'rubygems'
	require 'nokogiri'
	require 'rest_client'
	require 'open-uri'

	def self.getPage
		url = 'http://ehl_xbox.consolehockey.com/ajax/raspisanie/month/'

		if page = RestClient.post(url, {'tournament_id' => '153', 'month' => '11','year' => '2013', 'team_id' => '817', 'security_ls_key' => '638e427ad25439c05c35844b77f10c12', 'ALTO_AJAX' => '1'})
			puts 'Success finding calendar'
			File.open("calendar.html", 'w'){|f| f.write page.body}

			npage = Nokogiri::HTML(page)
			puts npage
		end
	end
end
