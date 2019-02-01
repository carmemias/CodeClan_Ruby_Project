require("pry")

require_relative("../models/tag")

@tag1 = Tag.new({"name" => "groceries"})
@tag2 = Tag.new({"name" => "public transport"})
@tag3 = Tag.new({"name" => "leisure"})

[@tag1, @tag2, @tag3].each{ |tag| tag.save() }



binding.pry
nil
