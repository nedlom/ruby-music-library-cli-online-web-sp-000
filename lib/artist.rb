class Artist
  attr_accessor :name
  
  def initialize(name)
    @name = name
    @songs = []
    save
  end
  
  def songs
    @songs
  end
  
  @@all = []
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    self.new(name)
  end
  
  def add_song(song)
    if song.artist.class != self.class
      song.artist = self
      @songs << song if !@songs.include?(song)
    end
  end
end