#!/usr/bin/ruby -w
# ALBUM
# Copyright Mark Keane, All Rights Reserved, 2014
require_relative 'song.rb'
# Class that encodes details of an album.
class Album < Song
  attr_accessor :name, :tracks, :length, :artist,:owners, :id
  def initialize(name, tracks, length, artist, owners)
    @name = name
    @tracks = tracks
    @length = length
    @artist = artist
    @owners = owners
    @id = name.object_id
  end

  # Method that prints out the contents of an album object nicely.
  # how do I get then ablum full name and the associated artist??? :((((
  def to_s
    puts "the album #{@name} by #{@artist}. \n"
  end	

  # Method that checks if an object given to it is an album.
  def isa?
    instance_of?(Album)
  end

  # Method makes an album object; just uses Album.new; really
  # just being a bit explicit and obvious.

  def self.make_album(name,tracks, length, artist, owners)
    Album.new(name, tracks, length, artist, owners)
  end

  # Class Method that builds albums from song object's contents.
  # It returns an array of album objects.  It calls another class method that
  # builds a single album, given the name of that album.

  def self.build_all(albums = [])
    album_names = $songs.uniq{ |song| song.album} #uniq albums from $songs global.
    		
    #calls build for each album name once and appends result
    album_names.each do |song| #get each song and build the album from the name
      albums << build_an_album_called(song.album)
    end
    albums
  end

  # Class method that takes an album name, it finds all the sounds that are in that album
  # builds up arrays of the song-names (tracks), runtimes, artist names.  These all get used
  # to populate the various attributes of the album object.

  def self.build_an_album_called(album_name)
    #get the songs of the album
    songs_of_album = $songs.select{|song| song.album == album_name} #array of the song with given album name
    songs_lengths = songs_of_album.map(&:time).sum.to_f # sum up the arrays @time of songs into 1 float
    song_makers = songs_of_album.map(&:artist).uniq.join(" & ").to_s #the artists
    #owners = songs_of_album[0].owners.split(" ")	#gets owners of first song
    
    holders = songs_of_album.map(&:owners) #the owners

    if holders.uniq.size <= 1
      owners = holders
    else
      owners = []
    end
    # or array.sum { |a| a.time }
    
    Album.new(album_name, songs_of_album, songs_lengths, song_makers, holders)

  end
end
