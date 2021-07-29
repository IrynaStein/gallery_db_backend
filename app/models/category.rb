class Category < ActiveRecord::Base
    has_many :artworks

    #category is most popular because of the number of collections it belongs to

    # def self.popularity
    #     Category.all.each do |cat|
    #            cat.artworks.map {|artwork| artwork.collection}
    # end

end