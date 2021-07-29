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
    elsif req.patch.match(/artworks/ && req.post?)

      data = JSON.parse req.body.read
      category = Category.find_by(name: data['category'])
      task = Artwork.create(
        # text: data["text"],
        # category: category
        id: data.id,
        title: data.title,
        edition: data.edition,
        likes: data.likes,
        price: data.price,
        medium: data.medium,
        image: data.image,
        featured: data.featured,
        date_created: data.date_created,
        category: category
      )

      resp_artwork = {
        # id: task.id,
        # text: task.text,
        # category: task.category.name
        id: data.id,
        title: data.title,
        edition: data.edition,
        likes: data.likes,
        price: data.price,
        medium: data.medium,
        image: data.image,
        featured: data.featured,
        date_created: data.date_created,
        category: data.category.name
      }

      return [200, { 'Content-Type' => 'application/json' }, [{ artwork: resp_artwork }.to_json]]
      
    else
      resp.write 'Path not Found, Iryna'
    end
    resp.finish
  end
end
