require('pry-byebug')
require_relative('../models/artist')
require_relative('../models/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'David Bowie'})
artist1.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'title'=> 'Rise and Fall of Ziggy Stardust',
  'genre'=> 'Rock'
})

album2 = Album.new({
 'artist_id' => artist1.id,
 'title'=> 'Hunky Dory',
 'genre'=> 'Rock'
})

album3 = Album.new({
  'artist_id' => artist1.id,
  'title'=> 'Pin Ups',
  'genre'=> 'Rock'
})


album1.save()
album2.save()
album3.save()


binding.pry
nil