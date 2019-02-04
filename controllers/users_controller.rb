require_relative("../models/user")

# edit
get "/users/:id/edit" do
  @user = User.find_by_id(params[:id].to_i)
  erb(:'users/edit')
end

# update
post "/users/:id" do
  params['budget'] = ( params['budget'].to_f() * 100 ).to_s()
  @user = User.new(params)
  @user.update()
  erb(:'users/show')
  # try redirect to('/users')
end

# view single
get "/users/:id" do
  @user = User.find_by_id(params[:id].to_i)
  erb(:'users/show')
end
