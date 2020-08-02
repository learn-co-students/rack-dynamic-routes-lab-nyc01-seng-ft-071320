class Application 

    @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]

    def call (env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last

                if item_var = @@items.find{|item| item.name == item_name}
                    resp.status = 200
                    resp.write item_var.price
            
                else 
                    resp.status = 400
                    resp.write "Item not found"
                end
        
        else
            resp.status = 404
            resp.write "Route not found"
        end

        resp.finish
    end
end