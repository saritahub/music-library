require '/Users/saritaradia/Desktop/Projects/music-library/lib/artist.rb'

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects.
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    artists = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']
      artists << artist
    end
    return artists
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, genre FROM artist WHERE id = $1;
    # Returns a single Artist object.

    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record =  result_set[0]

    artist = Artist.new  #New model Class object
    #Pulls the data from the associated table columns
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']

    return artist

  end



end