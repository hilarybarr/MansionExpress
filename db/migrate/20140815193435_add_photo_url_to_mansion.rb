class AddPhotoUrlToMansion < ActiveRecord::Migration

  def change
  	add_column :mansions, :photo_url, :text
  end
end
 