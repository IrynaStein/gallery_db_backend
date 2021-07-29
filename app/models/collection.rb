class Collection < ActiveRecord::Base
    belongs_to :artwork
    belongs_to :collector
end