require_relative('../db/sql_runner.rb')

class Booking

  attr_accessor :member_id, :gym_class_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_id = options['member_id'].to_i
    @gym_class_id = options['gym_class_id'].to_i
  end

  ## CRUD Functionality

  def save()
    sql = "INSERT INTO bookings
          (member_id, gym_class_id)
          VALUES ($1, $2)
          RETURNING id"
    values = [@member_id, @gym_class_id]
    result = SqlRunner.run(sql, values)
    @id = result.first['id']
  end

  def update()
    sql = "UPDATE bookings SET
          (member_id, gym_class_id)
          = ($1, $2)
          WHERE id = $3"
    values = [@member_id, @gym_class_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM bookings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  ## Class Methods

  def self.map_items(booking_data)
    return booking_data.map { |booking| Booking.new(booking) }
  end

  def self.all()
    sql = "SELECT * FROM bookings"
    booking_data = SqlRunner.run(sql)
    bookings = map_items(booking_data)
    return bookings
  end

end
