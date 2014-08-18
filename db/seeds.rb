
# STILL NEED TO MOVE IMAGES TO AMAZON WEBSERVICES AND REMOVE FROM PUBLIC/MANSION_IMAGES

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
  require_relative 'personality_traits_amenities'


# Add Caribbean and Central America
  caribbean=['http://www.luxuryretreats.com/destinations/caribbean/turks-and-caicos', 'http://www.luxuryretreats.com/destinations/caribbean/anguilla', 'http://www.luxuryretreats.com/destinations/caribbean/bahamas', 'http://www.luxuryretreats.com/destinations/caribbean/barbados', 'http://www.luxuryretreats.com/destinations/caribbean/bonaire', 'http://www.luxuryretreats.com/destinations/caribbean/dominican-republic', 'http://www.luxuryretreats.com/destinations/caribbean/grenada', 'http://www.luxuryretreats.com/destinations/caribbean/jamaica', 'http://www.luxuryretreats.com/destinations/caribbean/nevis', 'http://www.luxuryretreats.com/destinations/caribbean/puerto-rico', 'http://www.luxuryretreats.com/destinations/caribbean/st-barts', 'http://www.luxuryretreats.com/destinations/caribbean/st-croix', 'http://www.luxuryretreats.com/destinations/caribbean/st-john', 'http://www.luxuryretreats.com/destinations/caribbean/st-lucia', 'http://www.luxuryretreats.com/destinations/caribbean/st-martin', 'http://www.luxuryretreats.com/destinations/caribbean/st-thomas',  'http://www.luxuryretreats.com/destinations/caribbean/tortola', 'http://www.luxuryretreats.com/destinations/caribbean/turks-and-caicos', 'http://www.luxuryretreats.com/destinations/caribbean/virgin-gorda']

  centralamerica=["http://www.luxuryretreats.com/destinations/central-america/costa-rica/", "http://www.luxuryretreats.com/destinations/central-america/belize/"]

  url_array= caribbean + centralamerica 

  url_array.each do |url|
    doc = Nokogiri::HTML(open(url)) #open the content of the URL and bring into Nokogiri
      doc.css(".villaBlockContainer").each do |block| 
       name= block.css('div.villaRegionTitle h2').text 
       price=block.at_css(".vpMin").text#[/[0-9\.]+/] 
       description = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Unde voluptatum, distinctio repellendus, eos velit at error pariatur! Voluptate rerum, impedit amet minima, vero repellendus veritatis esse, neque magni, nostrum sed. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aspernatur pariatur impedit repellendus consequatur praesentium blanditiis maxime saepe odio ipsam maiores, voluptatem facilis quae quas soluta voluptates tenetur, eligendi cumque aliquid.'
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
          price: price,
          description: description,
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
       price=block.at_css(".vpMin").text#[/[0-9\.]+/] 
       description = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Unde voluptatum, distinctio repellendus, eos velit at error pariatur! Voluptate rerum, impedit amet minima, vero repellendus veritatis esse, neque magni, nostrum sed. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aspernatur pariatur impedit repellendus consequatur praesentium blanditiis maxime saepe odio ipsam maiores, voluptatem facilis quae quas soluta voluptates tenetur, eligendi cumque aliquid.'
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
          price: price,
          description: description,
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
       price=block.at_css(".vpMin").text#[/[0-9\.]+/] 
       description = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Unde voluptatum, distinctio repellendus, eos velit at error pariatur! Voluptate rerum, impedit amet minima, vero repellendus veritatis esse, neque magni, nostrum sed. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aspernatur pariatur impedit repellendus consequatur praesentium blanditiis maxime saepe odio ipsam maiores, voluptatem facilis quae quas soluta voluptates tenetur, eligendi cumque aliquid.'
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
          price: price,
          description: description,
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
       price=block.at_css(".vpMin").text#[/[0-9\.]+/] 
       description = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Unde voluptatum, distinctio repellendus, eos velit at error pariatur! Voluptate rerum, impedit amet minima, vero repellendus veritatis esse, neque magni, nostrum sed. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aspernatur pariatur impedit repellendus consequatur praesentium blanditiis maxime saepe odio ipsam maiores, voluptatem facilis quae quas soluta voluptates tenetur, eligendi cumque aliquid.'
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
          price: price,
          description: description,
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
       price=block.at_css(".vpMin").text#[/[0-9\.]+/] 
       description = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Unde voluptatum, distinctio repellendus, eos velit at error pariatur! Voluptate rerum, impedit amet minima, vero repellendus veritatis esse, neque magni, nostrum sed. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aspernatur pariatur impedit repellendus consequatur praesentium blanditiis maxime saepe odio ipsam maiores, voluptatem facilis quae quas soluta voluptates tenetur, eligendi cumque aliquid.'
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
          price: price,
          description: description,
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
  
# # CREATING PERSONALITY TRAITS TAGS

@professions.each do |profession| 
  PersonalityTrait.create(name: profession, category: "professions")
end

@religions.each do |religion| 
  PersonalityTrait.create(name: religion, category: "religions")
end

@sexual_orientations.each do |orientation| 
  PersonalityTrait.create(name: orientation, category: "sexual orientations")
end

@relationship_status.each do |status| 
  PersonalityTrait.create(name: status, category: "relationship status")
end

@smoker.each do |option| 
  PersonalityTrait.create(name: option, category: "smoker?")
end

@random_traits.each do |trait|
  PersonalityTrait.create(name: trait, category: "random_traits")
end

@music_styles.each do |music_style| 
  PersonalityTrait.create(name: music_style, category: "music styles")
end


# CREATING MANSION AMENITIES TAGS

@mansion_amenities.each do |amenity| 
  MansionAmenity.create(name: amenity)
end

# ADDING PERSONALITY TRAIT TAGS TO DUMMY USERS RANDOMLY

# CREATING DUMMY USERS

dummy_users = []
(0..20).each do |i|
  dummy_users << User.create(email: "test#{i}@gmail.com", password: "test12345")
end

# ADDING TRAITS TO DUMMY USERS
dummy_users.each do |user|
  traits = []
  20.times do 
    traits << PersonalityTrait.all.sample
  end
  user.personality_traits = traits
end


software=PersonalityTrait.create(name: "Super Software Engineer", category: "professions")


farheen=User.create(name: "Farheen Malik", email:"farheen@malik.com", password: "igeekallweek")
farheen.personality_traits << software
farheen.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  farheen.mansions << Mansion.find(rand(1..205))
end


hilary=User.create(name: "Hilary Barr", email:"hbarr@gmail.com", password: "igeekallweek")
hilary.personality_traits << software
hilary.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  hilary.mansions << Mansion.find(rand(1..205))
end

cassie=User.create(name: "Cassie Moy", email:"cassie@moy.com", password: "igeekallweek")
cassie.personality_traits << software
cassie.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  cassie.mansions << Mansion.find(rand(1..205))
end

molly=User.create(name: "Molly Huerster", email:"molly@huerster.com", password: "igeekallweek")
molly.personality_traits << software
molly.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  molly.mansions << Mansion.find(rand(1..205))
end

anthony=User.create(name: "Anthony Edwards", email:"anthony@edwards.com", password: "igeekallweek")
anthony.personality_traits << software
anthony.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  anthony.mansions << Mansion.find(rand(1..205))
end

justin=User.create(name: "Justin Lee", email:"justin@lee.com", password: "igeekallweek")
justin.personality_traits << software
justin.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  justin.mansions << Mansion.find(rand(1..205))
end

dylan=User.create(name: "Dylan Krause", email:"dylan@krause.com", password: "igeekallweek")
dylan.personality_traits << software
dylan.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  dylan.mansions << Mansion.find(rand(1..205))
end

alan=User.create(name: "Alan Florendo", email:"alan@florendo.com", password: "igeekallweek")
alan.personality_traits << software
alan.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  alan.mansions << Mansion.find(rand(1..205))
end

eric=User.create(name: "Eric Hou", email:"eric@hou.com", password: "igeekallweek")
eric.personality_traits << software
eric.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  eric.mansions << Mansion.find(rand(1..205))
end

rootul=User.create(name: "Rootul Patel", email:"rootul@patel.com", password: "igeekallweek")
rootul.personality_traits << software
rootul.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  rootul.mansions << Mansion.find(rand(1..205))
end

fahia=User.create(name: "Fahia Mo", email:"fahia@mo.com", password: "igeekallweek")
fahia.personality_traits << software
fahia.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
mansions=(1..200).to_a
200.times do
  fahia.mansions << Mansion.find(mansions.shift)
end

dylan=User.create(name: "Dylan Richards", email:"dylan@richards.com", password: "igeekallweek")
dylan.personality_traits << software
dylan.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  dylan.mansions << Mansion.find(rand(1..205))
end

daniel=User.create(name: "Daniel Deepak", email:"daniel@deepak.com", password: "igeekallweek")
daniel.personality_traits << software
daniel.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  daniel.mansions << Mansion.find(rand(1..205))
end

david=User.create(name: "David Sin", email:"david@sin.com", password: "igeekallweek")
david.personality_traits << software
david.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  david.mansions << Mansion.find(rand(1..205))
end

elz=User.create(name: "Elz Bellz", email:"elz@bells.com", password: "igeekallweek")
elz.personality_traits << software
elz.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  elz.mansions << Mansion.find(rand(1..205))
end

stephen=User.create(name: "Stephen Estrada", email:"stephen@estrada.com", password: "igeekallweek")
stephen.personality_traits << software
stephen.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  stephen.mansions << Mansion.find(rand(1..205))
end

michael=User.create(name: "Michael Weiss", email:"michael@weiss.com", password: "igeekallweek")
michael.personality_traits << software
michael.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  michael.mansions << Mansion.find(rand(1..205))
end

derek=User.create(name: "Derek Siker", email:"derek@siker.com", password: "igeekallweek")
derek.personality_traits << software
derek.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  derek.mansions << Mansion.find(rand(1..205))
end

john=User.create(name: "John Berry", email:"john@berry.com", password: "igeekallweek")
john.personality_traits << software
john.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  john.mansions << Mansion.find(rand(1..205))
end

julius=User.create(name: "Julius Jung", email:"julius@jung.com", password: "igeekallweek")
julius.personality_traits << software
julius.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  julius.mansions << Mansion.find(rand(1..205))
end

avi=User.create(name: "Avi Foxi", email:"avi@foxi.com", password: "igeekallweek")
avi.personality_traits << software
avi.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  avi.mansions << Mansion.find(rand(1..205))
end

chad=User.create(name: "Chad Saunders", email:"chad@saunders.com", password: "igeekallweek")
chad.personality_traits << software
chad.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
10.times do
  chad.mansions << Mansion.find(rand(1..205))
end

christian=User.create(name: "Christian Our King Moon", email:"christian@moon.com", password: "igeekallweek")
christian.personality_traits << software
christian.personality_traits << PersonalityTrait.where(name:"in an open relationship").first
mansions=(1..200).to_a
200.times do
  christian.mansions << Mansion.find(mansions.shift)
end
