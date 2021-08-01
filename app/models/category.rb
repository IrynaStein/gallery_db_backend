class Category < ActiveRecord::Base
  has_many :artworks

  def self.render_categories
    self.all.map do |category|
      {
        id: category.id,
        name: category.name,
        popularity: category.popularity
      }
    end
  end

  def category_popularity
    self.popularity=self.artworks.map {|a| {:name => a.category.name, :popularity => a.collectors.count}}.sum {|cat| cat[:popularity]}
    self
  end

  def self.sort_by_popularity
   Category.all.map {|c| c.category_popularity}.sort{|a,b| b.popularity<=>a.popularity}
  end
end
