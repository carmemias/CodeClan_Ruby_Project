require_relative( '../db/sql_runner' )
require_relative('../models/merchant')
require_relative('../models/tag')

class Transaction
  attr_reader :id
  attr_accessor :amount, :time, :tag_id, :merchant_id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @amount = options['amount'].to_i()
    @transaction_time = options['transaction_time']
    @tag_id = options['tag_id'].to_i()
    @merchant_id = options['merchant_id'].to_i()
  end

  # create
  def save()
    sql = "INSERT INTO transactions (amount, transaction_time, tag_id, merchant_id) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@amount, @transaction_time, @tag_id, @merchant_id]
    returned_id = SqlRunner.run(sql, values)[0]['id'].to_i()
    @id = returned_id
  end

  # find merchant
  def merchant()
    sql = "SELECT * FROM merchants WHERE id = $1;"
    values = [@merchant_id]
    result = SqlRunner.run(sql, values)
    return Merchant.new(result[0]) if result
  end

  # find tag
  def tag()
    sql = "SELECT * FROM tags WHERE id = $1;"
    values = [@tag_id]
    result = SqlRunner.run(sql, values)
    return Tag.new(result[0]) if result
  end

  def time_as_string()
    DateTime.parse(@transaction_time).strftime( "%A, %e %B %Y at %I:%M %P")
  end

  # list all
  def self.find_all()
    sql = "SELECT * FROM transactions;"
    results = SqlRunner.run(sql)
    return results.map{ |transaction_data| Transaction.new(transaction_data) } if results.count() > 0
  end

  # list all, by date
  def self.find_all_by_date()
    sql = "SELECT * FROM transactions ORDER BY transaction_time;"
    results = SqlRunner.run(sql)
    return results.map{ |transaction_data| Transaction.new(transaction_data) } if results.count() > 0
  end

  # delete all
  def self.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  # total amount for all transactions
  def self.calculate_total_spend()
    all_transactions = Transaction.find_all()
    total = 0
    all_transactions.each { |transaction| total += transaction.amount }
    return total
  end
end
