class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :featured
      t.integer :created_datetime
      t.string :short_description
      t.string :description
      t.string :number_of_players
      t.string :play_length
      t.string :image
    end
  end
end