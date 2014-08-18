class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :bookings
	has_many :mansions, through: :bookings     
	has_many :personality_trait_users
	has_many :personality_traits, through: :personality_trait_users

	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>", :join => '50x50>' }
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

	accepts_nested_attributes_for :personality_traits

	


end
