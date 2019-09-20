require_relative('../models/member.rb')
require_relative('../models/gymclass.rb')
require_relative('../models/booking.rb')
require('pry')

member1 = Member.new({
  'first_name' => 'Kevin',
  'last_name' => 'McDermott',
  'premium_member' => true
  })

member2 = Member.new({
  'first_name' => 'Niall',
  'last_name' => 'Morris',
  'premium_member' => false
  })

member1.save()
member2.save()

gym_class1 = GymClass.new({
  'name' => 'Crossfit',
  'start_time' => '10:00',
  'capacity' => '20'
  })

gym_class2 = GymClass.new({
  'name' => 'Weightlifting',
  'start_time' => '13:00',
  'capacity' => '10'
  })

gym_class1.save()
gym_class2.save()

booking1 = Booking.new({
  'member_id' => member1.id,
  'gym_class_id' => gym_class1.id
  })

booking2 = Booking.new({
  'member_id' => member2.id,
  'gym_class_id' => gym_class1.id
  })

booking1.save()
booking2.save()

binding.pry
nil
