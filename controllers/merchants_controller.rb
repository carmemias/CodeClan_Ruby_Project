require_relative("../models/merchants")

# create
get '/merchants/new' do
  erb(:'merchants/new')
end

# save
post '/merchants' do # route must be created as get first
  @merchant = Merchant.new(params)
  @merchant.save()
  erb(:'merchants/index') #needs new method
end

# edit
get '/merchants/:id/edit' do
  @merchant = Merchant.find_by_id(params[:id].to_i) # needs new method
  erb(:'merchants/edit')
end

# update
post 'merchants/:id' do
  @merchant = Merchant.new(params)
  @merchant.update()
  erb(:'/merchants/show') # needs new method
end

# delete
post '/merchants/:id/delete' do
  merchant = Merchant.find_by_id(params[:id].to_i) # needs new method
  merchant.delete() if merchant
  redirect to(:'/merchants/index') # route must be created
end
