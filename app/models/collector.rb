class Collector < ActiveRecord::Base
    has_many :collections
    has_many :artworks, through: :collections
end