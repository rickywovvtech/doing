class AddPictureToWowgram < ActiveRecord::Migration[6.0]
  def change
    add_attachment :wowgrams, :picture
  end
end
