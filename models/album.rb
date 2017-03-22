require('pg')
require_relative('../db/sql_runner')
require_relative('album')

class Album

  attr_accessor :title, :genre
  attr_reader :id, :artist_id

  def initialize( options )
    @title = options['title']
    @genre = options['genre'].to_i
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "
    INSERT INTO albums (
      topping,
      quantity,
      customer_id
    ) VALUES (
      '#{ @topping }',
      #{ @quantity },
      #{ @customer_id }
    )
    RETURNING id;"
    result = SqlRunner.run(sql)
    @id = result.first()["id"].to_i
  end

  def update()
    sql = "
    UPDATE pizza_orders SET (
      topping,
      quantity,
      customer_id
    ) = (
      '#{@topping}',
      #{@quantity},
      #{@customer_id} )
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM pizza_orders where id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.find(id)
    db = PG.connect( { dbname: 'pizza_shop', host: 'localhost' } )
    sql = "SELECT * FROM pizza_orders WHERE id = #{id}"
    db.exec(sql)
    db.close
  end

  def self.delete_all()
    sql = "DELETE FROM pizza_orders"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM pizza_orders;"
    orders = SqlRunner.run(sql)
    return orders.map { |order| PizzaOrder.new( order ) }
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = #{@customer_id}"
    result = SqlRunner.run(sql)
    customer_data = result.first
    customer = Customer.new(customer_data)
    return customer
  end

end