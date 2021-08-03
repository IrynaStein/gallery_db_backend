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
    a = data['art_id']
        .reject { |art| art.empty? }
        .map { |art| Artwork.find_by_title(art) }
        .map { |c| c.id }
    # save the artwork_ids to an array "a"
    # remove empty strings from the received array of artist_ids
    # Collector.artwork_ids= a
    # Collector.create(name: Laura, artwork_ids: [1,2,3])
    cNew = Collector.create(
      first_name: data['first_name'],
      last_name: data['last_name'],
      email: data['email'],
      full_address: data['address'],
      phone_num: data['phone'],
      artwork_ids: a
    )

    resp_collector = {
      id: cNew.id,
      first_name: cNew.first_name,
      last_name: cNew.last_name,
      email: cNew.email,
      address: cNew.full_address,
      phone: cNew.phone_num
    }
  end

  def self.find_works_with_categories(id)
    Collector.find_by_id(id).artworks.map do |work|
      { id: work[:id], title: work[:title],
        category: Category.find_by_id(work[:category_id]).name }
    end
  end
end
