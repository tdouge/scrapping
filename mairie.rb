require 'rubygems'
require 'nokogiri'
require 'open-uri'


PAGE_URL = "http://annuaire-des-mairies.com/val-d-oise.html"
def get_the_email_of_a_townhal_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	my_hash = {}
	my_hash[(page.css("tbody td")[0].to_s[22...-5]).to_sym] = page.css("tbody td")[7].to_s[4...-5]
	return my_hash
end

def get_all_the_urls_of_val_doise_townhalls
	tab = []
	page = Nokogiri::HTML(open(PAGE_URL))
	links = page.css('a[class="lientxt"]')
	for i in links
		tab.push("http://annuaire-des-mairies.com" + i["href"].to_s[1...i["href"].to_s.length])
	end
	return tab
end

def perform
	t = get_all_the_urls_of_val_doise_townhalls
	tab = []
	for i in t
		page = Nokogiri::HTML(open(i))
		tab.push(get_the_email_of_a_townhal_from_its_webpage(i))
	end
	return tab
end
puts perform
