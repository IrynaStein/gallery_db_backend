class Artwork < ActiveRecord::Base
  belongs_to :category
  has_many :collections
  has_many :collectors, through: :collections

  def self.render_artworks
    all.map do |artwork|
      {
        id: artwork.id,
        title: artwork.title,
        edition: artwork.edition,
        likes: artwork.likes,
        price: artwork.price,
        medium: artwork.medium,
        image: artwork.image,
        featured: artwork.featured,
        date_created: artwork.date_created,
        category: artwork.category.name
      }
    end
  end

  def self.find_by_path(path)
    id = path.split('/artworks/').last
    find_by_id(id)
  end

  def works_by_collector
    self.collectors.map {|collector| {:name => collector.first_name + " " + collector.last_name, 
        :id => collector.id, :collection => collector.artworks}}
  end 


  def self.create_new_with_association(data)
    category = Category.find_by(name: data['category'])
    # binding.pry
    artwork = self.create(
        title: data['title'],
        edition: data['edition'],
        likes: data['likes'],
        price: data['price'],
        medium: data['medium'],
        image: data['image'],
        featured: data['featured'],
        date_created: data['date_created'],
        category: category
      )

      resp_artwork = {
        id: artwork.id,
        title: artwork.title,
        edition: artwork.edition,
        likes: artwork.likes,
        price: artwork.price,
        medium: artwork.medium,
        image: artwork.image,
        featured: artwork.featured,
        date_created: artwork.date_created,
        category: artwork.category.name
      }
  end

  def update_likes(data)
    self.update(:likes => data["likes"])

    artwork = {
      id: self.id,
      title: self.title,
      edition: self.edition,
      likes: self.likes,
      price: self.price,
      medium: self.medium,
      image: self.image,
      featured: self.featured,
      date_created: self.date_created,
      category: self.category.name
    }
  end

end
