require_relative( '../db/sql_runner' )

class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i() if options['id']
  end

  # create
  def save()
    sql = "INSERT INTO merchants (name) VALUES ($1) RETURNING id;"
    values = [@name]
    returned_id = SqlRunner.run(sql, values)[0]['id'].to_i()
    @id = returned_id
  end

  # edit
  def update()
    sql = "UPDATE merchants SET name = $2 WHERE id = $1;"
    values = [@id, @name]
    SqlRunner.run(sql, values)
  end

  # delete
  def delete()
    sql = "DELETE FROM merchants WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM merchants;"
    SqlRunner.run(sql)
  end

  def self.find_all()
    sql = "SELECT * FROM merchants;"
    results = SqlRunner.run(sql)
    return results.map{ |row| Merchant.new(row) } if results.count() > 0
  end
end
