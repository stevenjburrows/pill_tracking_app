require_relative('../db/sql_runner')

class Pill

  attr_reader :id, :name, :type, :strength

  def initialize ( options )
    @id = options['id'].to_i if options['id'],
    @name = options['name'],
    @type = options['type'],
    @strength = options['strength']

  end

  def save
    sql = "INSERT INTO pills (
          name,
          type,
          strength
          )
      VALUES (
          $1, $2, $3
          )
      RETURNING *"
    values = [@name, @type, @strength]
    pill = SqlRunner.run(sql, values)
    @id = pill.first['id'].to_i
  end

  def update
    sql = "UPDATE pills SET (
          name,
          type,
          strength
          ) =
          ( $1, $2, $3)
      WHERE id = $4"
    values = [@name, @type, @strength, @id]
    SqlRunner.run(sql, values)

  end

  def self.all
    sql = "SELECT * FROM pills"
    pills = SqlRunner.run(sql)
    result = pills.map { |pill| Pill.new(pill) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM pills WHERE id = $1"
    values = [id]
    pill = SqlRunner.run(sql, values)
    result = Pill.new(pill.first)
    return result

  end
end
