require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/booking.rb')
require_relative('../models/gymclass.rb')
require_relative('../models/member.rb')
also_reload('../models/*')

get '/bookings/:id/new' do
  @gym_class = GymClass.find(params[:id])
  @members = Member.all()
  erb (:"bookings/new")
end

post '/bookings' do
  @booking = Booking.new(params)
  @booking.save()
  redirect to('/classes')
end

post '/bookings/:member_id/:gym_class_id/delete' do
  Booking.delete(params[:member_id], params[:gym_class_id])
  redirect to ('/classes')
end
