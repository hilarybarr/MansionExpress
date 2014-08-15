
# lib, task, write rake task for nokogiri and pushing to csv.


RAKETASK:

In lib/tasks create new rake task:

rails g task importer 







allVillas={}

.open(url)


.css(find by attribute villaBlock).each do |block|
	villa={}

	villa[:image_url]=block.css   [0]["href"]

	allVillas < villa

end



Put our allVillas into a csv file
Save all those image urls and put on flickr








SEED FILE:
Take from CSV file and store in database





# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# /private/tmp/www.luxuryretreats.com/


# Mansions:
### -Picture
# -Country
# -City
# -Price
# -Max_Occupancy
# -Bedrooms
# -Bathrooms

#picture must be given same id or name

# itemprop=pricerange (split by comma, take first element)
# itemprop=address
# itemprop=addressRegion
# itemprop=addressCountry
# id=villavitals (split by comma, first element is bedrooms, second element is bathrooms)
# id=fullview, p 2, description
# li? = max_occupancy

# .
# require 'rubygems'
# require 'nokogiri'
# require 'open-uri'
# require 'csv'

# #files=all the html files files
# Dir.foreach("parent_directory") do |folder|
#     Dir.foreach("#{folder}"} do |file|
#        doc = Nokogiri::HTML(open("#{file}")) 
#     end
# end









Mansion.create(
	
	country: 
	city:
	price:
	max_occupancy:
	bedrooms:
	bathrooms:
	description: 



	)