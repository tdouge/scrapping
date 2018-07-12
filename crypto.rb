require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"

tab = []
while 1
	page = Nokogiri::HTML(open(PAGE_URL))
	crypto = page.css('a[class="currency-name-container link-secondary"]')
	cours = page.css('a[class="price"]')
	crypto.each_with_index do |e, i|
		tab.push({e.text.to_sym => cours[i].text})		
	 end

	puts tab
	tab =[]
	sleep(3600)
end
