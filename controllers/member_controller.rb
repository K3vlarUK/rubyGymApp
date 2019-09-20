require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/member.rb')
also_reload('../models/*')

get '/members' do
  @members = Member.all()
  erb (:"members/index")
end

get '/members/new' do
  erb (:"members/new")
end

get '/members/:id' do
  @member = Member.find(params[:id])
  erb (:"members/show")
end

post '/members' do
  @member = Member.new(params)
  @member.save()
  redirect to ('/members')
end

get '/members/:id/edit' do
  @member = Member.find(params[:id])
  erb (:"members/edit")
end

post '/members/:id' do
  @updated_member = Member.new(params)
  @updated_member.update()
  redirect to ('/members')
end

post '/members/:id/delete' do
  Member.delete(params[:id])
  redirect to('/members')
end
