require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=576"

page = Nokogiri::HTML(open(PAGE_URL))
tab =[]
links = page.css('ul[class="no_puce list_ann"]')
for i in links
	begin
		tab.push({:first_name => i.css("li")[0].text.split[1].to_s, 
			:last_name => i.css("li")[0].text.split[2],
			:email => i.css("li")[4].text.to_s[9...i.css("li")[4].text.to_s.length]})
	rescue NoMethodError
		tab.push({:first_name => i.css("li")[0].text.split[1].to_s, 
			:last_name => i.css("li")[0].text.split[2],
			:email => i.css("li")[3].text.to_s[9...i.css("li")[3].text.to_s.length]})
	end
end

puts tab

