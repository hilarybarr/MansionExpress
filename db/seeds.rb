
# The below code works and will seed our database.
# However, this needs to be refactored such that the importing and adding to CSV file is done in a custom
# raketask (do rails g task importer) and the parsing of CSV and turning of each item into
# Ruby objects is done in the seedfile.	


	require 'nokogiri'
	require 'open-uri' #let's us grab contents of url


		url = 'http://www.luxuryretreats.com/destinations/caribbean/turks-and-caicos/grace-bay'
		doc = Nokogiri::HTML(open(url)) #open the content of the URL and bring into Nokogiri
		
	
	
		  doc.css(".villaBlockContainer").each do |block| 
		 	
			 
			 name= block.css('div.villaRegionTitle h2').text 
			 price=block.at_css(".vpMin").text[/[0-9\.]+/] 
			 city=block.at_css(".locationName").text
			 country= block.at_css(".regionName").text
			 region=block.at_css(".destinationName").text
			 photo_url=block.at_css(".villaPhoto")[:src]
			 bedrooms= block.at_css("span.bedCount").text
			 bathrooms=block.at_css("span.bathCount").text
			 source=block.at_css(".villaDetailsLink a")[:href]   # for our use only...so we can track where we got listing
			unless bedrooms=="0"
				Mansion.create!(
					name: name,
					price: price.to_i,
					city: city,
					country: country,
					region: region,
					photo_url: photo_url,
					bedrooms: bedrooms.to_i,
					bathrooms: bathrooms.to_i,
					source: source
					)
			end
			
		
		  end

		








	# require 'nokogiri'
	# require 'open-uri' #let's us grab contents of url


	# 	url = 'http://www.luxuryretreats.com/destinations/caribbean/turks-and-caicos/grace-bay'
	# 	doc = Nokogiri::HTML(open(url)) #open the content of the URL and bring into Nokogiri
		
	# 	allVillas=[]

		
	# 	  doc.css(".villaBlockContainer").each do |block| 
	# 	 	villa={}
			 
	# 		 villa[:name]= block.css('div.villaRegionTitle h2').text 
	# 		 villa[:price]=block.at_css(".vpMin").text[/[0-9\.]+/] 
	# 		 villa[:city]=block.at_css(".locationName").text
	# 		 villa[:country]= block.at_css(".regionName").text
	# 		 villa[:region]=block.at_css(".destinationName").text
	# 		 villa[:photo]=block.at_css(".villaPhoto")[:src]
	# 		 villa[:bedrooms]= block.at_css("span.bedCount").text
	# 		 villa[:bathrooms]=block.at_css("span.bathCount").text
	# 		 villa[:source]=block.at_css(".villaDetailsLink a")[:href]   # for our use only...so we can track where we got listing
	
	# 		 allVillas << villa if villa[:min_price] != "0" && villa[:title] != ""
		
	# 	  end

	# 	puts allVillas
		












