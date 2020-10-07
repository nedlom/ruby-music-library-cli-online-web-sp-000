require 'pry'
class MusicLibraryController
  
  def initialize(path='./db/mp3s')
    MusicImporter.new(path).import
  end
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = ""
    while input != "exit"
      input = gets.strip
      if input == "list songs"
        list_songs
      elsif input == "list artists"
        list_artists
      elsif input == "list genres"
        list_genres
      elsif input == "list artist"
        list_songs_by_artist
      elsif input == "list genre"
        list_songs_by_genre  
      elsif input == "play song"
        play_song 
      end
    end
  end
  
  #Check all songs being duplicated.
  def list_songs
    x = Song.all.uniq
    #x = Song.all.collect{|a| a.name}
    #binding.pry
    x.sort!{|a,b| a.name <=> b.name}
    x.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    x = Artist.all.collect{|a| a.name}
    x.sort!
    x.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist}"
    end
  end

  def list_genres
    x = Genre.all.collect{|g| g.name}
    x.sort!
    x.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    artist = Artist.all.detect{|a| a.name == input}
    if artist
      songs = artist.songs
      x = songs.collect{|s| [s.name, s.genre.name]}
      x.sort!{|a,b| a[0] <=> b[0]}
      #song is an array [song.name, song.genre.name]
      x.each_with_index do |song, i|
        puts "#{i + 1}. #{song[0]} - #{song[1]}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    genre = Genre.all.detect{|g| g.name == input}
    if genre
      songs = genre.songs
      x = songs.collect{|s| [s.artist.name, s.name]}
      x.sort!{|a,b| a[1] <=> b[1]}
      x.each_with_index do |array, i|
        puts "#{i + 1}. #{array[0]} - #{array[1]}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip
    input = input.to_i
    x = Song.all.uniq
    x.sort!{|a,b| a.name <=> b.name}
    y = x.length
    #binding.pry
    if (1..y).include?(input)
      input -= 1
      puts "Playing #{x[input].name} by #{x[input].artist.name}" 
    end
  end
  
#   expect($stdout).to receive(:puts).with("Which song number would you like to play?")
#       expect($stdout).to receive(:puts).with("Playing Larry Csonka by Action Bronson")
  # def call
  #   puts "Welcome to your music library!"
  #   input = gets.strip
  #   if input == "list songs"
  #     list_songs
  #   elsif input == "list artists"
  #     list_artists
  #   elsif input == "list genres"
  #     list_genres
  #   elsif input == "list artist"
  #     list_songs_by_artist
  #   elsif input == "list genre"
  #     list_songs_by_genre  
  #   elsif input == "play song"
  #     play_song 
  #   end
  # end
    
end