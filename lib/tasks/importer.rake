desc "Import mansion listings" #task description
task :importer => :environment do #loads rails environment
	require 'nokogiri'
	require 'open-uri' #let's us grab contents of url

	#Product.find_all_by_price(nil).each do |product|
	

		url = 'http://www.luxuryretreats.com/destinations/caribbean/turks-and-caicos/grace-bay'
		doc = Nokogiri::HTML(open(url)) #open the content of the URL and bring into Nokogiri
		
		allVillas=[]

		doc.css("villaBlockContainer").each do |block|
			villa={}
			
			href=         #for our use only, if we need to go back to that listing
			title=block.css     .villaRegionTitle["h2"]
			image_url=.villaPhoto
			minprice=block.css(".vpMin")
			bedrooms=.bedcount
			bathrooms=.bathcount
			city= .locationName         
			country=.regionName       
			region=.destinationName



		end

		



.css(find by attribute villaBlock).each do |block|
	villa={}

	villa[:image_url]=block.css   [0]["href"]

	allVillas < villa

end



Put our allVillas into a csv file


		price = doc.at_css(".camelPrice").text[/\$[0-9\.]+/] #extracts price
		#product.update_attribute(:price, price) #update each product price attribute to be the price that we found/scraped
		

		end
	end
end



puts doc.at_css("title").text #extract the title, in this case we first grab the css selector and grab the text associated with that element by calling .text
doc.css(".item").each do |item| #for each of the items do:
	title = puts item.at_css(".ListItemLink").text #extracs title
	price = item.at_css(".camelPrice").text[/\$[0-9\.]+/] #extracts price
	puts "#{title} - #{price}"
	puts item.at_css(".ListItemLink")[:href] #extracts URL
end

#Then you would just run $rake fetch_prices and boom, you're good.


end
