require('pg')
require_relative('../db/sql_runner')
require_relative('album')

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING *"
    result = SqlRunner.run(sql)
    @id = result.first()["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    artists = result.map {|artist| Artist.new(artist)}
    return artists
  end

  # def pizza_orders()
  #   sql = "SELECT * FROM pizza_orders WHERE customer_id = #{@id}"
  #   result = SqlRunner.run(sql)
  #   orders  = result.map { |order| PizzaOrder.new(order) }
  #   return orders
  # end

end