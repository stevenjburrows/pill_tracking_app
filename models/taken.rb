require_relative('../db/sql_runner')

class Taken

  attr_reader :id, :user_id, :pill_id, :quantity, :time_taken

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @user_id = options['user_id'].to_i
    @pill_id = options['pill_id'].to_i
    @quantity = options['quantity'].to_i
    @time_taken = options['time_taken']

  end

  def save
    sql = "INSERT INTO pills_taken (
          user_id,
          pill_id,
          quantity,
          time_taken
          )
      values (
          $1, $2, $3, $4
        )
      RETURNING *"
    values = [@user_id, @pill_id, @quantity, @time_taken]
    taken = SqlRunner.run(sql, values)
    @id = taken.first['id'].to_i

  end

  def self.find_by_pill_id(id)
    sql = "SELECT * FROM pills_taken where pill_id = $1"
    values = [id]
    taken = SqlRunner.run(sql, values)
    result = Taken.new(taken.first)
    return result
  end

  end
