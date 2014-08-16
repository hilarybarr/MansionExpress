class Mansion < ActiveRecord::Base
	has_many :mansion_amenities
	has_many :amenities, through: :mansion_amenities
	has_many :pledges
	has_many :guests, through: :pledges, source: :user
	belongs_to :mansion_review

	has_many :bookings
	has_many :users, through: :bookings


	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
