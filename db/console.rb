require('pry-byebug')
require_relative('../models/artist')
require_relative('../models/album')

Artist.delete_all()
Album.delete_all()

artist1 = Artist.new({'name' => 'David Bowie'})
artist1.save()

artist2 = Artist.new({'name' => 'David Bowie'})
artist2.save()

artist3 = Artist.new({'name' => 'David Bowie'})
artist3.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'title'=> 'Rise and Fall of Ziggy Stardust',
  'genre'=> 'Rock'
})

album2 = Album.new({
 'artist_id' => artist2.id,
 'title'=> 'Hunky Dory',
 'genre'=> 'Rock'
})

album3 = Album.new({
  'artist_id' => artist3.id,
  'title'=> 'Pin Ups',
  'genre'=> 'Rock'
})

album1.save()
album2.save()
album3.save()

binding.pry
nil