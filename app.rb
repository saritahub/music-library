require '/Users/saritaradia/Desktop/Projects/music-library/lib/database_connection.rb'
require '/Users/saritaradia/Desktop/Projects/music-library/lib/artist_repository.rb'
require '/Users/saritaradia/Desktop/Projects/music-library/lib/02_albumsrepo.rb'
# Make sure this connects to your test database

DatabaseConnection.connect('music_library_test')

# # Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM albums;'
# result = DatabaseConnection.exec_params(sql, [])
# # OUTPUT: #<PG::Result:0x000000014d9004e0 status=PGRES_TUPLES_OK ntuples=14 nfields=2 cmd_tuples=14>
#
# result.each do |record|
#     p record
#   end

#The above is replaced by calling the ArtistRepository Class
# This connects to the MAIN database, not test

# artist_repository = ArtistRepository.new
# artist_repository.all.each do |artist|
#   p artist
# end
# This prints out a list of artist objects

#Conntects to AlbumRepository Class
#Main database, not test 

# album_repo = AlbumRepository.new
# album_repo.all.each do |album|
#   p album.title
# end
#
# artist_repo = ArtistRepository.new
# artist_repo.all.each do |artist|
#   p artist
# end

# repo = ArtistRepository.new
#
# artist = repo.find(1)
# p artist.name  #real data output
#
# album_repo = AlbumRepository.new
# album = album_repo.find(3)
# p album.title

#07 Wrapping the program in an Application Class



 class Application

# #     # The Application class initializer
# #     # takes four arguments:
# #     #  * The database name to call `DatabaseConnection.connect`
# #     #  * the Kernel object as `io` (so we can mock the IO in our tests)
# #     #  * the AlbumRepository object (or a double of it)
# #     #  * the ArtistRepository object (or a double of it)
    def initialize(database_name, io, album_repository, artist_repository)
      DatabaseConnection.connect(database_name)
      @terminal_io = io
      @album_repository = album_repository
      @artist_repository = artist_repository
    end
  
    def run
      @terminal_io.puts "Welcome to the music library manager!"
      @terminal_io.puts "What would you like to do?"
      @terminal_io.puts "1 - List all albums"
      @terminal_io.puts "2 - List all artists"
      @terminal_io.print "Enter your choice:"
      user_choice = @terminal_io.gets.chomp

        if user_choice == "1"
          # artist_repo = ArtistRepository.new
          @artist_repository.all.each do |artist|
            @terminal_io.puts "#{artist.id} - #{artist.name}"
       end
        elsif user_choice == "2"
            # album_repo = AlbumRepository.new
            @album_repository.all.each do |album|
              @terminal_io.puts "#{album.id} - #{album.title}"
            end
        end
    end
  end
  
  if __FILE__ == $0
    app = Application.new(
      'music_library_test',
      Kernel,
      AlbumRepository.new,
      ArtistRepository.new
    )  #Change back to music_library
    app.run
   end

