class CreateWowgrams < ActiveRecord::Migration[6.0]
  def change
    create_table :wowgrams do |t|
        t.belongs_to :user
        t.string :description
        t.string :body
      t.timestamps
    end
  end
end
