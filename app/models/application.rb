class Application
    def call(env)
      response = Rack::Response.new
      request = Rack::Request.new(env)
  
      # handle all routes and send appropriate responses
    end
  end