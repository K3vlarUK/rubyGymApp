require_relative('../db/sql_runner.rb')

class GymClass

  attr_accessor :name, :start_time, :capacity, :attendees
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @start_time = options['start_time']
    @capacity = options['capacity'].to_i
  end

  ## CRUD functionality

  def save()
    sql = "INSERT INTO gymclasses
          (name, start_time, capacity)
          VALUES ($1, $2, $3)
          RETURNING id"
    values = [@name, @start_time, @capacity]
    result = SqlRunner.run(sql, values)
    @id = result.first['id']
  end

  def update()
    sql = "UPDATE gymclasses SET
          (name, start_time, capacity)
          = ($1, $2, $3)
          WHERE id = $4"
    values = [@name, @start_time, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def members()
    sql = "SELECT members.* FROM members
          INNER JOIN bookings
          ON bookings.member_id = members.id
          WHERE gym_class_id = $1"
    values = [@id]
    members = SqlRunner.run(sql, values)
    result = members.map { |member| Member.new(member)}
    return result
  end

  def is_full?()
    if members().length >= @capacity
      return true
    else
      return false
    end
  end

  ## Class Methods

  def self.map_items(gym_class_data)
    return gym_class_data.map { |gym_class| GymClass.new(gym_class) }
  end

  def self.all()
    sql = "SELECT * FROM gymclasses"
    gym_class_data = SqlRunner.run(sql)
    gym_classes = map_items(gym_class_data)
    return gym_classes
  end

  def self.find(id)
    sql = "SELECT * FROM gymclasses WHERE id = $1"
    values = [id]
    gym_class = SqlRunner.run(sql, values)
    result = GymClass.new(gym_class.first)
    return result
  end

  def self.delete(id)
    sql = "DELETE FROM gymclasses WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

end
