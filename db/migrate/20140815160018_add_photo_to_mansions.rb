class AddPhotoToMansions < ActiveRecord::Migration
	def self.up
		add_attachment :mansions, :photo
	end

	def self.down
		remove_attachment :mansions, :photo
	end
end
