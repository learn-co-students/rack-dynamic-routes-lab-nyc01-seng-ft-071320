class Application
    @@items = [Item.new("Brocoli", 4.99), Item.new("Tomatoes", 5.99)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            #turns /items/Brocoli into just Brocoli
            item = @@items.find{|i| i.name == item_name}
            if item
                resp.write item.price
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