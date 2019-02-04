require("pry")
require_relative( '../db/sql_runner' )

class User
  attr_reader :id
  attr_accessor :first_name, :last_name, :budget

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @budget = options['budget'].to_i() if options['budget']
  end

  # save
  def save()
    sql = "INSERT INTO users (first_name, last_name, budget) VALUES ($1, $2, $3) RETURNING id;"
    values = [@first_name, @last_name, @budget]
    returned_id = SqlRunner.run(sql, values)
    @id = returned_id[0]['id'].to_i()
  end

  # update
  def update()
    sql = "UPDATE users SET (first_name, last_name, budget) = ($2, $3, $4) WHERE id = $1;"
    values = [@id, @first_name, @last_name, @budget]
    SqlRunner.run(sql, values)
  end

  def near_budget_limit?()
    return Transaction.calculate_total_spend() >= @budget * 0.9
  end

  # find by id
  def self.find_by_id(id)
    sql = "SELECT * FROM users WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    return User.new(result[0]) if result
  end

  def self.find_all()
    sql = "SELECT * FROM users;"
    results = SqlRunner.run(sql)
    return results.map{|user_data| User.new(user_data)} if results
  end

  # delete
  def self.delete_all()
    sql = "DELETE FROM users;"
    SqlRunner.run(sql)
  end

end
