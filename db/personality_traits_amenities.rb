@professions = [ "advertising",
	"accounting",
	"airline",
	"banking",
	"education",
	"energy",
	"finance",
	"fashion",
	"health care",
	"legal",
	"motion picture video",
	"music",
	"publishing journalism",
	"real estate",
	"software",
	"sports",
	"other" ]

@religions = [ "none",
	"catholic",
	"christian",
	"jewish",
	"muslim",
	"orthodox",
	"buddhist",
	"hindu",
	"other" ]

@sexual_orientations = [ "straight",
	"gay",
	"bisexual",
	"other" ]

@relationship_status = [ "single",
	"married",
	"in an open relationship",
	"divorced",
	"widowed",
	"it's complicated" ]

@smoker = [ "yes",
	"no",
	"socially" ]

@random_traits = [ "student",
	"entrepreneur",
	"vegetarian",
	"total carnivore",
	"early bird",
	"night owl",
	"dog lover",
	"cat lover",
	"democrat",
	"republican",
	"bookworm",
	"social butterfly" ]

@music_styles = [ "rock",
	"electronic music",
	"dubstep",
	"rap hip hop",
	"latin",
	"jazz",
	"classical",
	"reggae",
	"techno",
	"country",
	"dance music",
	"indie" ]

@mansion_amenities = [ "heating",
	"air conditioning",
	"washer",
	"dryer",
	"parking",
	"wireless internet",
	"cable tv",
	"pets allowed",
	"smoking allowed",
	"wheelchair accessible",
	"elevator",
	"fireplace",
	"doorman",
	"pool",
	"hot yub",
	"gym",
	"bbq grill" ]


p total_personality_traits = @professions.count + @religions.count + @sexual_orientations.count + @relationship_status.count + @smoker.count + @random_traits.count + @music_styles.count



@mansions=Mansion.all
5.times do
	 @mansions.each do |mansion|
	  mansion.amenities << @mansion_amenities.sample
	 end
end






