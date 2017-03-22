require('pg')
require_relative('../db/sql_runner')
require_relative('artist')

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
      title,
      genre,
      artist_id
    ) VALUES (
      '#{ @title }',
      #{ @genre },
      #{ @artist_id }
    )
    RETURNING id;"
    result = SqlRunner.run(sql)
    @id = result.first()["id"].to_i
  end

  def update()
    sql = "
    UPDATE albums SET (
      title,
      genre,
      artist_id
    ) = (
      '#{@title}',
      #{@genre},
      #{@artist_id} )
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM albums where id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.find(id)
    db = PG.connect( { dbname: 'music_app', host: 'localhost' } )
    sql = "SELECT * FROM albums WHERE id = #{id}"
    db.exec(sql)
    db.close
  end

  def self.all()
    sql = "SELECT * FROM albums;"
    orders = SqlRunner.run(sql)
    return orders.map { |order| Album.new( order ) }
  end

  # def customer()
  #   sql = "SELECT * FROM customers WHERE id = #{@artist_id}"
  #   result = SqlRunner.run(sql)
  #   customer_data = result.first
  #   customer = Artist.new(customer_data)
  #   return customer
  # end

end