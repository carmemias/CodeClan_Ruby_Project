require_relative( '../db/sql_runner' )

class Tag
  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i() if options['id']
  end
end
