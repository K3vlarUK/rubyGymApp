require_relative('../db/sql_runner.rb')

class Member

  attr_accessor :first_name, :last_name, :premium_member
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @premium_member = options['premium_member']
  end

  ## CRUD functionality

  def save()
    sql = "INSERT INTO members
          (first_name, last_name, premium_member)
          VALUES ($1, $2, $3)
          RETURNING id"
    values = [@first_name, @last_name, @premium_member]
    result = SqlRunner.run(sql, values)
    @id = result.first['id']
  end

  def update()
    sql = "UPDATE members SET
          (first_name, last_name, premium_member)
          = ($1, $2, $3)
          WHERE id = $4"
    values = [@first_name, @last_name, @premium_member, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  ## Ease of Use

  def merge_name()
    return "#{@first_name.capitalize()} #{@last_name.capitalize()}"
  end

  ## Class Methods

  def self.map_items(member_data)
    return member_data.map { |member| Member.new(member) }
  end

  def self.all()
    sql = "SELECT * FROM members"
    member_data = SqlRunner.run(sql)
    members = map_items(member_data)
    return members
  end

  def self.find(id)
    sql = "SELECT * FROM members WHERE id = $1"
    values = [id]
    member = SqlRunner.run(sql, values)
    result = Member.new(member.first)
    return result
  end

end
