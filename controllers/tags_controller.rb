require("pry")
require_relative("../models/tag")

# show all
get '/tags' do
  @tags = Tag.find_all() # needs new method
  erb(:'tags/index')
end

# create
get '/tags/new' do
  erb(:'tags/new')
end

# save
post '/tags' do
  @tag = Tag.new(params)
  @tag.save()
  erb(:'tags/show')
end

# edit
get '/tags/:id/edit' do
  @tag = Tag.find_by_id(params['id'].to_i()) # needs new method
  erb(:'tags/edit')
end

# delete single
post '/tags/:id/delete' do
  @tag = Tag.find_by_id(params['id'].to_i())
  @tag.delete()
  redirect to('/tags')
end

# show single
get '/tags/:id' do
  @tag = Tag.find_by_id(params['id'].to_i())
  @error_message = "Tag not found." unless @tag
  erb(:'tags/show')
end

# update
post '/tags/:id' do
  @tag = Tag.new(params)
  @tag.update()
  erb(:'tags/show')
end
