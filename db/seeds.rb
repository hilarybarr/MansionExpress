

#We included gem 'seed_dump'.
# After you finish running rake db:seed, run rake db:seed:dump. 
# Copy what is now in rake db:seed into a new file (i.e. seedbackup.rb).
# In terminal run git checkout db/seeds.rb (or whatever name of file is in git status) assuming your 
#last git commit was up to date.
# This will keep your seeding file as is but you will have a copy of what you retrieved in seedbackup.rb

# To add every image locally: 
#Inside public/mansion_images
# rails c
#irb(main):004:0> Mansion.all.pluck("photo_url").each do |url| 
#irb(main):005:1* `wget #{url}`
#end


  require 'nokogiri'
  require 'open-uri' #let's us grab contents of url

# Add Caribbean and Central America
  caribbean=['http://www.luxuryretreats.com/destinations/caribbean/turks-and-caicos', 'http://www.luxuryretreats.com/destinations/caribbean/anguilla', 'http://www.luxuryretreats.com/destinations/caribbean/bahamas', 'http://www.luxuryretreats.com/destinations/caribbean/barbados', 'http://www.luxuryretreats.com/destinations/caribbean/bonaire', 'http://www.luxuryretreats.com/destinations/caribbean/dominican-republic', 'http://www.luxuryretreats.com/destinations/caribbean/grenada', 'http://www.luxuryretreats.com/destinations/caribbean/jamaica', 'http://www.luxuryretreats.com/destinations/caribbean/nevis', 'http://www.luxuryretreats.com/destinations/caribbean/puerto-rico', 'http://www.luxuryretreats.com/destinations/caribbean/st-barts', 'http://www.luxuryretreats.com/destinations/caribbean/st-croix', 'http://www.luxuryretreats.com/destinations/caribbean/st-john', 'http://www.luxuryretreats.com/destinations/caribbean/st-lucia', 'http://www.luxuryretreats.com/destinations/caribbean/st-martin', 'http://www.luxuryretreats.com/destinations/caribbean/st-thomas',  'http://www.luxuryretreats.com/destinations/caribbean/tortola', 'http://www.luxuryretreats.com/destinations/caribbean/turks-and-caicos', 'http://www.luxuryretreats.com/destinations/caribbean/virgin-gorda']

  centralamerica=["http://www.luxuryretreats.com/destinations/central-america/costa-rica/", "http://www.luxuryretreats.com/destinations/central-america/belize/"]

  url_array= caribbean + centralamerica 

  url_array.each do |url|
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
       unless bedrooms=="0"   #Makes sure we don't add empty listings
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
    end


# Add North America
    
  mexico= ["http://www.luxuryretreats.com/destinations/north-america/mexico/cabo-san-lucas", "http://www.luxuryretreats.com/destinations/north-america/mexico/puerto-vallarta", "http://www.luxuryretreats.com/destinations/north-america/mexico/punta-mita", "http://www.luxuryretreats.com/destinations/north-america/mexico/riviera-maya"]

  united_states=[ "http://www.luxuryretreats.com/destinations/north-america/united-states/california---desert-cities/", "http://www.luxuryretreats.com/destinations/north-america/united-states/california---lake-tahoe/", "http://www.luxuryretreats.com/destinations/north-america/united-states/colorado-vail-valley/", "http://www.luxuryretreats.com/destinations/north-america/united-states/florida---the-palm-beaches/" ]

  north_america= mexico + united_states

  north_america.each do |url|
    doc = Nokogiri::HTML(open(url)) #open the content of the URL and bring into Nokogiri
      doc.css(".villaBlockContainer").each do |block| 
       name= block.css('div.villaRegionTitle h2').text 
       price=block.at_css(".vpMin").text[/[0-9\.]+/] 
       city=block.at_css(".regionName").text
       region= "North America"
       country=block.at_css(".destinationName").text
       photo_url=block.at_css(".villaPhoto")[:src]
       bedrooms= block.at_css("span.bedCount").text
       bathrooms=block.at_css("span.bathCount").text
       source=block.at_css(".villaDetailsLink a")[:href]   # for our use only...so we can track where we got listing
      unless bedrooms=="0"   #Makes sure we don't add empty listings
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
    end



# #Add Asia
  thailand=["http://www.luxuryretreats.com/destinations/asia/thailand/"]

  thailand.each do |url|
    doc = Nokogiri::HTML(open(url)) #open the content of the URL and bring into Nokogiri
      doc.css(".villaBlockContainer").each do |block| 
       name= block.css('div.villaRegionTitle h2').text 
       price=block.at_css(".vpMin").text[/[0-9\.]+/] 
       city=block.at_css(".regionName").text
       region= "Asia"
       country=block.at_css(".destinationName").text
       photo_url=block.at_css(".villaPhoto")[:src]
       bedrooms= block.at_css("span.bedCount").text
       bathrooms=block.at_css("span.bathCount").text
       source=block.at_css(".villaDetailsLink a")[:href]   # for our use only...so we can track where we got listing
      unless bedrooms=="0"   #Makes sure we don't add empty listings
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
    end




# #Add Europe

greece=["http://www.luxuryretreats.com/destinations/europe/austria/", 'http://www.luxuryretreats.com/destinations/europe/greece/crete/', 'http://www.luxuryretreats.com/destinations/europe/greece/mykonos/','http://www.luxuryretreats.com/destinations/europe/greece/paros/', 'http://www.luxuryretreats.com/destinations/europe/greece/santorini/', 'http://www.luxuryretreats.com/destinations/europe/greece/zakynthos/'] 

france= ['http://www.luxuryretreats.com/destinations/france/provence/', 'http://www.luxuryretreats.com/destinations/france/corsica/', 'http://www.luxuryretreats.com/destinations/france/paris/', 'http://www.luxuryretreats.com/destinations/france/french-alps/']    

italy= ['http://www.luxuryretreats.com/destinations/italy/amalfi-coast/', 'http://www.luxuryretreats.com/destinations/italy/lake-como/', 'http://www.luxuryretreats.com/destinations/italy/sardinia/', 'http://www.luxuryretreats.com/destinations/italy/tuscany/', 'http://www.luxuryretreats.com/destinations/italy/umbria/']

europe=greece + france + italy


  europe.each do |url|
    doc = Nokogiri::HTML(open(url)) #open the content of the URL and bring into Nokogiri
      doc.css(".villaBlockContainer").each do |block| 
       name= block.css('div.villaRegionTitle h2').text 
       price=block.at_css(".vpMin").text[/[0-9\.]+/] 
       city=block.at_css(".regionName").text
       region= "Europe"
       country=block.at_css(".destinationName").text
       photo_url=block.at_css(".villaPhoto")[:src]
       bedrooms= block.at_css("span.bedCount").text
       bathrooms=block.at_css("span.bathCount").text
       source=block.at_css(".villaDetailsLink a")[:href]   # for our use only...so we can track where we got listing
       unless bedrooms=="0"   #Makes sure we don't add empty listings
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
    end



# #Add Africa
africa=["http://www.luxuryretreats.com/destinations/africa/south-africa/"]
  africa.each do |url|
    doc = Nokogiri::HTML(open(url)) #open the content of the URL and bring into Nokogiri
      doc.css(".villaBlockContainer").each do |block| 
       name= block.css('div.villaRegionTitle h2').text 
       price=block.at_css(".vpMin").text[/[0-9\.]+/] 
       city=block.at_css(".regionName").text
       region= "Africa"
       country=block.at_css(".destinationName").text
       photo_url=block.at_css(".villaPhoto")[:src]
       bedrooms= block.at_css("span.bedCount").text
       bathrooms=block.at_css("span.bathCount").text
       source=block.at_css(".villaDetailsLink a")[:href]   # for our use only...so we can track where we got listing
       unless bedrooms=="0"   #Makes sure we don't add empty listings
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
    end



#   # require 'nokogiri'
#   # require 'open-uri' #let's us grab contents of url


#   #   url = 'http://www.luxuryretreats.com/destinations/caribbean/turks-and-caicos/grace-bay'
#   #   doc = Nokogiri::HTML(open(url)) #open the content of the URL and bring into Nokogiri
    
#   #   allVillas=[]

    
#   #     doc.css(".villaBlockContainer").each do |block| 
#   #     villa={}
       
#   #      villa[:name]= block.css('div.villaRegionTitle h2').text 
#   #      villa[:price]=block.at_css(".vpMin").text[/[0-9\.]+/] 
#   #      villa[:city]=block.at_css(".locationName").text
#   #      villa[:country]= block.at_css(".regionName").text
#   #      villa[:region]=block.at_css(".destinationName").text
#   #      villa[:photo]=block.at_css(".villaPhoto")[:src]
#   #      villa[:bedrooms]= block.at_css("span.bedCount").text
#   #      villa[:bathrooms]=block.at_css("span.bathCount").text
#   #      villa[:source]=block.at_css(".villaDetailsLink a")[:href]   # for our use only...so we can track where we got listing
  
#   #      allVillas << villa if villa[:min_price] != "0" && villa[:title] != ""
    
#   #     end

#   #   puts allVillas
    











