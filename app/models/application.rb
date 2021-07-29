require 'pry'
require 'json'

class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/artworks/) && req.get?

      artwork = Artwork.all.map do |artwork|
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
          category: artwork.category
        }
      end
      category = Category.all.map do |category|
        {
          id: category.id,
          name: category.name,
          popularity: category.popularity
        }
      end

      return [200, { 'Content-Type' => 'application/json' },
              [{ artworks: artwork, categories: category, message: 'success' }.to_json]]
    elsif req.path.match(/artworks/) && req.post?
      # binding.pry
      data = JSON.parse(req.body.read)

      category = Category.find_by(name: data['category'])
      artwork = Artwork.create(
        # text: data["text"],
        # category: category
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
        # id: task.id,
        # text: task.text,
        # category: task.category.name
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

      return [200, { 'Content-Type' => 'application/json' }, [{ artwork: resp_artwork }.to_json]]

    elsif req.path.match(/artworks/) && req.delete?
      # binding.pry
      id = req.path.split('/artworks/').last
      Artwork.find_by_id(id).delete
      return [200, { 'Content-type' => 'application/json' }, [{ message: 'Artwork was successfully deleted' }.to_json]]

    elsif req.path.match(/collectors/) && req.get?
      collectors = Collector.all.map do |collector|
        {
          id: collector.id,
          first_name: collector.first_name,
          last_name: collector.last_name,
          email: collector.email,
          address: collector.full_address,
          phone: collector.phone_num
        }
      end
      return [200, {'Content-Type' => 'application/json'} , [{:collectors => collectors, :message => "success"}.to_json]]
    else
      resp.write 'Path not Found, buddy. Try again'
    end
    resp.finish
  end
end
