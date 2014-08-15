class Pledge < ActiveRecord::Base
  belongs_to :guest
  belongs_to :mansion
end
