require("pry")

require_relative("../models/tag")
require_relative("../models/merchant")
require_relative("../models/transaction")

@tag1 = Tag.new({"name" => "groceries"})
@tag2 = Tag.new({"name" => "public transport"})
@tag3 = Tag.new({"name" => "leisure"})

[@tag1, @tag2, @tag3].each{ |tag| tag.save() }

@merchant1 = Merchant.new({"name" => "Morrisons"})
@merchant2 = Merchant.new({"name" => "Boots"})
@merchant3 = Merchant.new({"name" => "SPT"})
@merchant4 = Merchant.new({"name" => "Cineworld"})

[@merchant1, @merchant2, @merchant3, @merchant4].each{ |merchant| merchant.save() }

@transaction1 = Transaction.new({"amount" => 5203, "tag_id" => @tag1.id, "merchant_id" => @merchant1.id})
@transaction2 = Transaction.new({"amount" => 2000, "tag_id" => @tag2.id, "merchant_id" => @merchant3.id})
@transaction3 = Transaction.new({"amount" => 800, "tag_id" => @tag3.id, "merchant_id" => @merchant4.id})
@transaction4 = Transaction.new({"amount" => 385, "tag_id" => @tag1.id, "merchant_id" => @merchant1.id})

[@transaction1, @transaction2, @transaction3, @transaction4].each{ |transaction| transaction.save() }

binding.pry
nil
