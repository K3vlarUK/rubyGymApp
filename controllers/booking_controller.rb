require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/booking.rb')
require_relative('../models/gymclass.rb')
require_relative('../models/member.rb')
also_reload('../models/*')

get '/bookings' do
  @bookings = Booking.all()
  erb (:"bookings/index")
end

get '/bookings/new' do
  @gym_classes = GymClass.all()
  @members = Member.all()
  erb (:"bookings/new")
end

post '/bookings' do
  @booking = Booking.new(params)
  @booking.save()
  redirect to('/classes')
end
