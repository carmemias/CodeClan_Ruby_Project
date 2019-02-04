require("pry")

require_relative("../models/transaction")
require_relative("../models/tag")
require_relative("../models/merchant")

# view all
get '/transactions' do
  @all_tags = Tag.find_all()

  if !params
    @all_transactions = Transaction.find_all()
  else
    @all_transactions = Transaction.filter(params['tag_id'], params['start_date'], params['end_date'], params['order'])
  end
  #
  # if params['tag_id'] != ""
  #   @all_transactions = Transaction.find_by_tag(params['tag_id'].to_i())
  # elsif params['tag_id'] == "" && (params['start_date'] || params['end_date'])
  #   @all_transactions = Transaction.find_by_date(params['start_date'], params['end_date'])
  # else
  #
  # end

  erb(:'transactions/index')
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
