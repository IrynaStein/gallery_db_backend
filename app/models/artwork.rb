class Artwork < ActiveRecord::Base
    belongs_to :category
    has_many :collections
    has_many :collectors, through: :collections
end