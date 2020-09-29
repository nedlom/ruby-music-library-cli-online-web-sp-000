class Song
  attr_accessor :name, :artist
  
  def initialize(name, artist = "artist")
    @name = name
    self.artist = artist
    save
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
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

end