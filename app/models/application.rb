require 'pry'
require 'json'

class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

#ARTWORKS GET
    if req.path.match(/artworks/) && req.get?
      # binding.pry
      if req.path.split('/artworks/').last == '/artworks'
        return [200, { 'Content-Type' => 'application/json' },
                [{ artworks: Artwork.render_artworks,
                   categories: Category.render_categories, message: 'success' }.to_json]]    
      elsif req.path.split('/').last == 'showcategories'
        id = req.path.split('/')[2].to_i
        categories_list = Category.sort_by_popularity
        return [200, { 'Content-Type' => 'application/json' },
                [{ cat_popularity: categories_list, message: 'success' }.to_json]]
      else
        id = req.path.split('/artworks/').last
        artwork = Artwork.find_by_path(id).works_by_collector
        # binding.pry
        return [200, { 'Content-Type' => 'application/json' },
                [{ collector_list: artwork,
                   message: 'success' }.to_json]]
      end

#ARTWORKS POST REQUEST
    elsif req.path.match(/artworks/) && req.post?
      # binding.pry
      data = JSON.parse(req.body.read)
      artwork = Artwork.create_new_with_association(data)
      return [200, { 'Content-Type' => 'application/json' }, [{ artwork: artwork }.to_json]]
#ARTWORKS PATCH
    elsif req.path.match(/artworks/) && req.patch?
    binding.pry
    likesData = JSON.parse(req.body.read)
    id = req.path.split('/artworks/').last
    artwork = Artwork.find_by_path(id).update_likes(likesData)
      return [200, { 'Content-Type' => 'application/json' },
        [{ artwork: artwork, message: 'Likes updated' }.to_json]]
        
#ARTWORKS DELETE
    elsif req.path.match(/artworks/) && req.delete?
      Artwork.find_by_path(req.path).destroy
      return [200, { 'Content-Type' => 'application/json' },
              [{ message: 'Artwork was successfully deleted' }.to_json]]

#COLLECTORS GET
    elsif req.path.match(/collectors/) && req.get?
      # binding.pry
      if req.path.split('/collectors/').last == "/collectors"
      return [200, { 'Content-Type' => 'application/json' },
              [{ collectors: Collector.render_collectors, message: 'success' }.to_json]]
      else 
        id = req.path.split('/collectors/').last
       
        return [200, { 'Content-Type' => 'application/json' }, [{ artworks: Collector.find_works_with_categories(id), message: 'success' }.to_json]] 
      end
#COLLECTORS POST
    elsif req.path.match(/collectors/) && req.post?
      data = JSON.parse(req.body.read)
      # binding.pry
      collector = Collector.create_new_with_association(data)
      return [200, { 'Content-Type' => 'application/json' }, [{ collector: collector }.to_json]]

#COLLECTORS DELETE
    elsif req.path.match(/collectors/) && req.delete?
      Collector.find_by_path(req.path).destroy
      return [200, { 'Content-Type' => 'application/json' }, [{ message: 'Collector was succesfully deleted' }.to_json]]

#PATH NOT FOUND RESPONSE
    else
      resp.write 'Path not Found, buddy. Try again'
    end

    resp.finish
  end
end
