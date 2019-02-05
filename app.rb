require("sinatra")
require("sinatra/contrib/all")

require_relative("./controllers/tags_controller")
require_relative("./controllers/merchants_controller")
require_relative("./controllers/transactions_controller")
require_relative("./controllers/users_controller")
also_reload("./models/*")

get '/' do
  @user = User.find_all().first
  erb(:index)
end
