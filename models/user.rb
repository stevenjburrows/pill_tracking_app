require_relative('../db/sql_runner')
require_relative('taken')

class User

  attr_reader :id, :username, :age

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @username = options['username']
    @age = options['age'].to_i
  end

  def save
    sql = "INSERT INTO users (
          username,
          age
          )
      VALUES (
          $1, $2
            )
      RETURNING *"
    values  = [@username, @age]
    user = SqlRunner.run(sql, values)
    @id = user.first['id'].to_i
  end

  def update
    sql = "UPDATE users SET (
          username,
          age
          ) =
          ( $1, $2)
      WHERE id = $3"
    values = [@username, @age, @id]
    SqlRunner.run(sql, values)

  end


  def self.all
    sql = "SELECT * FROM users"
    users = SqlRunner.run(sql)
    result = users.map { |user| User.new(user)  }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM users where id = $1"
    values = [id]
    user = SqlRunner.run(sql, values)
    result = User.new(user.first)
    return result
  end
# for a given user id
# search the database for all the pills they have taken
# create a new instance for each of these pills
# return the result to be used

  def pills
    sql = "SELECT pills.* FROM users
          INNER JOIN pills_taken
          on pills_taken.user_id = users.id
          INNER JOIN pills
          on pills.id = pills_taken.pill_id
          where users.id = $1"
    values = [@id]
    pills = SqlRunner.run(sql, values)
    result = pills.map { |pill| Pill.new(pill) }
    return result
  end

end
