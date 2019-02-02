require_relative( '../db/sql_runner' )

class Tag
  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i() if options['id']
  end

  # create
  def save()
    sql = "INSERT INTO tags (name) VALUES ($1) RETURNING id;"
    values = [@name]
    returned_id = SqlRunner.run(sql, values)
    @id = returned_id[0]["id"].to_i()
  end

  # edit
  def update()
    sql = "UPDATE tags SET name = $2 WHERE id = $1;"
    values = [@id, @name]
    SqlRunner.run(sql, values)
  end

  # delete
  def delete()
    sql = "DELETE FROM tags WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # find linked transactions
  def transactions()
    sql = "SELECT * FROM transactions WHERE tag_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{ |transaction_data| Transaction.new(transaction_data) } if results
  end

  def self.delete_all()
    sql = "DELETE FROM tags;"
    SqlRunner.run(sql)
  end

  def self.find_all()
    sql = "SELECT * FROM tags ORDER BY id;"
    results = SqlRunner.run(sql)
    return results.map{ |tag_data| Tag.new(tag_data) } if results
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tags WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Tag.new(result[0]) if result
  end

end
