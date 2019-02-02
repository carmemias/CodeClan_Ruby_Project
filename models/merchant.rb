require_relative( '../db/sql_runner' )
require_relative( './transaction')

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
    returned_id = SqlRunner.run(sql, values)
    @id = returned_id[0]['id'].to_i()
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

  def transactions()
    sql = "SELECT * FROM transactions WHERE merchant_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{ |transaction_data| Transaction.new(transaction_data) } if results.count() > 0
  end

  def self.delete_all()
    sql = "DELETE FROM merchants;"
    SqlRunner.run(sql)
  end

  def self.find_all()
    sql = "SELECT * FROM merchants ORDER BY id;"
    results = SqlRunner.run(sql)
    return results.map{ |merchant_data| Merchant.new(merchant_data) } if results.count() > 0
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM merchants WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Merchant.new(result[0]) if result.count() > 0
  end
end
