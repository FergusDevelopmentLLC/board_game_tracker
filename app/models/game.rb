class Game < ActiveRecord::Base
    validates_presence_of :name
    validates_presence_of :featured
    validates_presence_of :created_datetime
    validates_presence_of :description
    validates_presence_of :number_of_players
    validates_presence_of :play_length
    validates_presence_of :image
end