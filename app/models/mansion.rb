class Mansion < ActiveRecord::Base
	has_many :mansion_amenities
	has_many :amenities, through: :mansion_amenities
	has_many :pledges
	has_many :guests, through: :pledges, source: :user
	has_many :bookings
	has_many :users, through: :bookings
	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	
	belongs_to :mansion_review

	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

	geocoded_by :address
	after_validation :geocode

	def users_count
		self.users.count
	end

	def address
	  [city, country].compact.join(', ')
	end

 end
