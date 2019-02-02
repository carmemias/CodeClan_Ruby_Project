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
#TODO it'd be great to have unique tag names here...
post '/tags' do
  @tag = Tag.new(params)
  @tag.save()
  erb(:'tags/show')
end

# edit
get '/tags/:id/edit' do
  @tag = Tag.find_by_id(params[:id].to_i()) # needs new method
  erb(:'tags/edit')
end

# delete single
# shows a view with a dropdown of current tags, get re-assignment tag
get '/tags/:id/delete' do
  @tag = Tag.find_by_id(params[:id].to_i())
  @all_tags = Tag.find_all()
  # Note that @all_tags.include?(@tag) will always return false as both methods
  # create new objects when pulling the data out of the database. So, if we wanted
  # the tags dropdown not to include the tag we are deleting, we would have to
  # remove it from the view by checking its id.

  # we must reassign transactions before deleting the tag.
  if @tag.transactions.count() > 0
    @transactions_exist = true
    # user selects a tag
  else
    @transactions_exist = false
    # message is displayed.
    # tag can be deleted
  end
  erb(:'tags/reassign_tag')
  # after this, we can proceed with re-assignment and delete
end

# delete single
# params passed on = {"new_tag_id"=>"59", "id" => "24"}
post '/tags/:id/delete' do
  @tag = Tag.find_by_id(params[:id].to_i())

  # transactions are re-assigned
  if params[:new_tag_id] != ""
    tag_transactions = @tag.transactions()

    tag_transactions.each do |transaction|
      transaction.tag_id = params[:new_tag_id].to_i()
      transaction.save()
    end
  end

  @tag.delete()
  redirect to('/tags')
end

# show single
get '/tags/:id' do
  @tag = Tag.find_by_id(params[:id].to_i())
  @error_message = "Tag not found." unless @tag
  erb(:'tags/show')
end

# update
post '/tags/:id' do
  @tag = Tag.new(params)
  @tag.update()
  erb(:'tags/show')
end
