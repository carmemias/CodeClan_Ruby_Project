require("pry")

require_relative("../models/transaction")
require_relative("../models/tag")
require_relative("../models/merchant")

# view all
get '/transactions' do
  @all_transactions = Transaction.find_all()
  erb(:'transactions/index')
end

# view all, by date
get '/transactions/by_date' do
  @all_transactions = Transaction.find_all_by_date()
  erb(:'transactions/index_by_date')
end

# create
get '/transactions/new' do
  @all_tags = Tag.find_all()
  @all_merchants = Merchant.find_all()
  erb(:'transactions/new')
end

# save
post '/transactions' do
  params['amount'] = ( params['amount'].to_f() * 100 ).to_s()
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:'transactions/show')
end
