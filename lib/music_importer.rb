class MusicImporter
  
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end
  
  def files
    Dir.children(path)
  end
  
  def import
    self.files.each{|f| Song.create_from_filename(f)}
  end
  
end