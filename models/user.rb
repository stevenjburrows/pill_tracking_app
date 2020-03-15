require_relative('../db/sql_runner')

class User

  attr_reader :id, :name, :age

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @age = options['age'].to_i
  end

  def save
    sql = "INSERT INTO users (
          name,
          age
          )
      VALUES (
          $1, $2
            )
      RETURNING *"
    values  = [@name, @age]
    user = SqlRunner.run(sql, values)
    @id = user.first['id'].to_i
  end

  def update
    sql = "UPDATE users SET (
          name,
          type,
          strength
          ) =
          ( $1, $2)
      WHERE id = $3"
    values = [@name, @age, @id]
    SqlRunner.run(sql, values)

  end

  def self.all
    sql = "SELCT * FROM users"
    users = SqlRunner.run(sql)
    result = users.map { |user| User.new(user)  }
    return user
  end

  def find(id)
    sql = "SELECT * FROM users where id = $1"
    values = ['id']
    user = SqlRunner(sql, values)
    result = User.new(user.first)
    result result
  end
end
