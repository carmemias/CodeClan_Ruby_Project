require("pry")
require_relative("../models/merchant")

# view all
get '/merchants' do
  @merchants = Merchant.find_all()
  erb(:'/merchants/index')
end

# create
get '/merchants/new' do
  erb(:'merchants/new')
end

# save
post '/merchants' do
  @merchant = Merchant.new(params)
  @merchant.save()
  erb(:'merchants/show')
end

# edit
get '/merchants/:id/edit' do
  @merchant = Merchant.find_by_id(params[:id].to_i)
  erb(:'merchants/edit')
end

# delete
post '/merchants/:id/delete' do
  merchant = Merchant.find_by_id(params[:id].to_i)

  if !merchant.transactions
    merchant.delete()
    redirect to('/merchants')
  else
    @error_message = "Sorry, merchant #{merchant.name} cannot be deleted because there are transactions linked to it."
    redirect to('/merchants')
  end
  # redirect to('/merchants'), @error_message
end

# show single
get '/merchants/:id' do
  @merchant = Merchant.find_by_id(params[:id].to_i)
  @error_message = "Merchant not found." if !@merchant
  erb(:'/merchants/show')
end

# update
post '/merchants/:id' do
  @merchant = Merchant.new(params)
  @merchant.update()
  erb(:'/merchants/show') # needs new method
end
