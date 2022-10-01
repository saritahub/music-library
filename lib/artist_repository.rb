require '/Users/saritaradia/Desktop/Projects/music-library/lib/artist.rb'

class ArtistRepository
  def all
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
  def create(artist)
    # The $1 and $2 are dynamic placeholders
    # Doesn't return anything (only creates the record)
    sql = 'INSERT INTO artists (name, genre) VALUES($1, $2);'
    sql_params = [artist.name, artist.genre]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  #Deletes an artist record given its id
  def delete(id)
    #Executes the SQL:
    # Returns nothing (only deletes the record)
    sql = 'DELETE FROM artists WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  # Updates an artist record
  # Takes an Artist object with the updated fields
  def update(artist)
    #Executes the SQL:
    # UPDATE artists SET name = $1, genre = $2 WHERE id = $3
    # Returns nothing, only updates the record
    sql = 'UPDATE artists SET name = $1, genre = $2 WHERE id = $3;'
    sql_params = [artist.name, artist.genre, artist.id]

    DatabaseConnection.exec_params(sql, sql_params)
  end

  # def find_with_albums(id)
  #   sql = 'SELECT artists.id,
  #                 artists.name,
  #                 artists.genre,
  #                 albums.id AS album_id,
  #                 albums.title,
  #                 albums.release_year
  #         FROM artists
  #         JOIN albums ON albums.artist_id = artists.id
  #         WHERE artists.id = $1;'
  #
  #   params = [id]
  #
  #   result = DatabaseConnection.exec_params(sql, params)
  #   record =  result[id]
  #
  #   artist = Artist.new
  #
  #   artist.id = record['id']
  #   artist.name = record['name']
  #   artist.genre = record['genre']
  #   # artist.albums = []
  #
  #
  #   result.each do |record|
  #     album = Album.new
  #     album.id = record['album_id']
  #     album.title = record['title']
  #     album.release_year = record['release_year']
  #
  #     artist.albums << album
  #   end
  #
  #   return artist
  # end
end