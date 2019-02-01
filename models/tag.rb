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
    returned_id = SqlRunner.run(sql, values)[0]["id"].to_i()
    @id = returned_id
  end

  # edit
  def update()
  end

  # delete
  def delete()
  end

  def self.delete_all()
  end

end
