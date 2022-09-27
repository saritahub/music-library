require '/Users/saritaradia/Desktop/Projects/music-library/lib/database_connection.rb'
require '/Users/saritaradia/Desktop/Projects/music-library/lib/artist_repository.rb'
# Make sure this connects to your test database

DatabaseConnection.connect('music_library')  

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

artist_repository = ArtistRepository.new
artist_repository.all.each do |artist|
  p artist
end
# This prints out a list of artist objects