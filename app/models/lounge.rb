class Lounge < ActiveRecord::Base
	belongs_to :mansion
  acts_as_commontable
end
