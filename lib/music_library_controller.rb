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
  
  # SOLVED
  # Check all songs being duplicated. 
  # Duplication was due to .save in lib/song #create_from_filename
  # requiring a .uniq on Song.all below
  def list_songs
    # songs = Song.all.uniq 
    # songs = songs.sort!{|a,b| a.name <=> b.name}
    Song.all.sort!{|a,b| a.name <=> b.name}
    Song.all.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    artists = Artist.all.collect{|a| a.name}.sort!
    artists.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist}"
    end
  end

  def list_genres
    genres = Genre.all.collect{|g| g.name}.sort!
    genres.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    artist = Artist.all.detect{|a| a.name == input}
    if !artist.nil?
      artist.songs.sort!{|a,b| a.name <=> b.name}
      artist.songs.each_with_index do |song, i|
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    genre = Genre.all.detect{|g| g.name == input}
    if !genre.nil?
      genre.songs.sort!{|a,b| a.name <=> b.name}
      genre.songs.each_with_index do |song, i|
        puts "#{i + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i 
    Song.all.sort!{|a,b| a.name <=> b.name}
    if input.between?(1, Song.all.length)
      puts "Playing #{Song.all[input-1].name} by #{Song.all[input-1].artist.name}"
    end
  end
end