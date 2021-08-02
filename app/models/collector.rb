class Collector < ActiveRecord::Base
  has_many :collections
  has_many :artworks, through: :collections

  def self.render_collectors
    all.map do |collector|
      {
        id: collector.id,
        first_name: collector.first_name,
        last_name: collector.last_name,
        email: collector.email,
        address: collector.full_address,
        phone: collector.phone_num
      }
    end
  end

  def self.find_by_path(path)
    id = path.split('/collectors/').last
    find_by_id(id)
  end

  def self.create_new_with_association(data)
    artwork1 = Artwork.find_by(id: data['art_id_1'])
    artwork2 = Artwork.find_by(id: data['art_id_2'])
   
#save the artwork_ids to an array "a"
    #remove empty strings from the received array of artist_ids
#Collector.artwork_ids= a
    collectorN = Collector.create(
      first_name: data['first_name'],
      last_name: data['last_name'],
      email: data['email'],
      full_address: data['address'],
      phone_num: data['phone']
    )
    collection = Collection.create(
      artwork: artwork1,
      collector: collectorN
    )

    collection2 = Collection.create(
      artwork: artwork2,
      collector: collectorN
    )

    # !artwork2.nil? ? Collection.create(artwork: artwork2, collector: collectorN) : Collection.new(artwork: artwork2, collector: collectorN)

    resp_collector = {
      id: collectorN.id,
      first_name: collectorN.first_name,
      last_name: collectorN.last_name,
      email: collectorN.email,
      address: collectorN.full_address,
      phone: collectorN.phone_num
    }
  end

  def self.find_works_with_categories(id)
    Collector.find_by_id(id).artworks.map do |work|
      { id: work[:id], title: work[:title],
        category: Category.find_by_id(work[:category_id]).name }
    end
  end

end
