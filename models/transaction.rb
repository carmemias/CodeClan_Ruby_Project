require_relative( '../db/sql_runner' )

class Transaction
  attr_reader :id
  attr_accessor :amount, :tag_id, :merchant_id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @tag_id = options['tag_id'].to_i()
    @merchant_id = options['merchant_id'].to_i()
    @amount = options['amount'].to_i()
  end
end
