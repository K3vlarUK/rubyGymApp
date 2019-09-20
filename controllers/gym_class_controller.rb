require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gymclass.rb')
also_reload('../models/*')

get '/classes' do
  @gym_classes = GymClass.all()
  erb (:"gym_classes/index")
end

# get '/classes/:id' do
#   @gym_class = GymClass.find(params[:id])
#   erb (:"gym_classes/show")
# end

get '/classes/new' do
  erb (:"gym_classes/new")
end

post '/classes' do
  @gym_class = GymClass.new(params)
  @gym_class.save()
  redirect to ('/classes')
end

post '/classes/:id/delete' do
  GymClass.delete(params[:id])
  redirect to ('/classes')
end
