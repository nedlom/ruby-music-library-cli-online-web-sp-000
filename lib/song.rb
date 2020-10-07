require 'pry'

class Song
  
  attr_accessor :name, :artist, :genre

  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def save
    self.class.all << self
  end
  
  def self.create(name, artist=nil, genre=nil)
    song = self.new(name, artist=nil, genre=nil)
    song.save
    song
  end
  
  def artist=(artist)
     @artist = artist
     artist.add_song(self) if !artist.nil?
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self) if !genre.nil?
  end
  
  def self.find_by_name(name)
    all.detect{|s| s.name == name}
  end
  
  def self.find_or_create_by_name(name)
    song = find_by_name(name)
    song.nil? ? create(name) : song
  end
  
  def self.new_from_filename(filename)
    filename = filename.split(/ - |.mp3/)
    song = find_or_create_by_name(filename[1])
    song.artist = Artist.find_or_create_by_name(filename[0])
    song.genre = Genre.find_or_create_by_name(filename[2])
    song
  end
  
  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end
end