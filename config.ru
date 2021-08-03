require_relative "./config/environment.rb"

use Rack::Cors do
  allow do
    #change * in origins to the url of your deployed front-end
    #add optional localhost:3000 to be able to make database 
    origins '*' 
    resource '/*', headers: :any, methods: [:get, :post, :patch, :put, :delete]
  end
end


run Application.new