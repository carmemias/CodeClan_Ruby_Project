require_relative( '../db/sql_runner' )
require_relative('../models/merchant')
require_relative('../models/tag')

require("pry")

class Transaction
  attr_reader :id
  attr_accessor :amount, :transaction_time, :tag_id, :merchant_id

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

  def self.filter(tag_id, start_date = Transaction.earliest_time(), end_date = Transaction.most_recent_time())
    # SELECT * FROM transactions WHERE tag_id = 34 AND transaction_time BETWEEN '2012-03-01 00:00:00'::timestamp AND '2018-10-31 00:00:00'::timestamp;
    if tag_id != '0'
      sql = "SELECT * FROM transactions WHERE tag_id = $1 AND transaction_time BETWEEN $2::timestamp AND $3::timestamp"
      values = [tag_id, start_date, end_date]
    else
      sql = "SELECT * FROM transactions WHERE transaction_time BETWEEN $1::timestamp AND $2::timestamp"
      values = [start_date, end_date]
    end
    results = SqlRunner.run(sql, values)
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

  def self.most_recent_time()
    sql = "SELECT * FROM transactions ORDER BY transaction_time DESC;"
    results = SqlRunner.run(sql)
    return DateTime.parse(Transaction.new(results.first).transaction_time).strftime("%FT%H:%M") if results
  end

  def self.earliest_time()
    sql = "SELECT * FROM transactions ORDER BY transaction_time ASC;"
    results = SqlRunner.run(sql)
    return DateTime.parse(Transaction.new(results.first).transaction_time).strftime("%FT%H:%M") if results
  end
end
