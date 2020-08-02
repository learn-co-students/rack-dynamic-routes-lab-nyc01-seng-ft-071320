require 'pry'

class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match (/items/)
      searched_item = req.path.split("/items/").last
      item = Item.items.find{|i| i.name == searched_item}
      #binding.pry
      if Item.items.include?(item)
        resp.write "#{item.price}"
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

end



