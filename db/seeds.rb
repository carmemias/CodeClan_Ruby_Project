require("pry")

require_relative("../models/tag")
require_relative("../models/merchant")

@tag1 = Tag.new({"name" => "groceries"})
@tag2 = Tag.new({"name" => "public transport"})
@tag3 = Tag.new({"name" => "leisure"})

[@tag1, @tag2, @tag3].each{ |tag| tag.save() }

@merchant1 = Merchant.new({"name" => "Morrisons"})
@merchant2 = Merchant.new({"name" => "Boots"})
@merchant3 = Merchant.new({"name" => "SPT"})
@merchant4 = Merchant.new({"name" => "Cineworld"})

[@merchant1, @merchant2, @merchant3, @merchant4].each{ |merchant| merchant.save() }

binding.pry
nil
