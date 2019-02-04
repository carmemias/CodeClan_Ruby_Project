require("pry")

require_relative("../models/transaction")
require_relative("../models/tag")
require_relative("../models/merchant")

# view all
get '/transactions' do
  @all_tags = Tag.find_all()

  if params.empty?
    @all_transactions = Transaction.find_all()
    @page_subtitle = "All Transactions"
  else
    @all_transactions = Transaction.filter(params['tag_id'], params['start_date'], params['end_date'])
    tag_name = Tag.find_by_id(params['tag_id']).name.capitalize() if params['tag_id'] != '0'
    start_date = DateTime.parse(params['start_date']).strftime("%e %B %Y, %I:%M %P")
    end_date = DateTime.parse(params['end_date']).strftime("%e %B %Y, %I:%M %P")
    @page_subtitle = "#{tag_name} Transactions, from #{start_date} to #{end_date}"
  end

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
