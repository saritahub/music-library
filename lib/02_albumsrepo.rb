require '/Users/saritaradia/Desktop/Projects/music-library/lib/02_albums.rb'

class AlbumRepository
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []

    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']
      albums << album
    end
    return albums
  end

  def find(id)
    sql = 'SELECT title, release_year, artist_id FROM albums WHERE id = $1;'

    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)

    record = result[0]
    album = Album.new
    album.id = record['id']
    album.title = record['title']
    album.release_year = record['release_year']
    album.artist_id = record['artist_id']

    return album
  end



end

# repo = AlbumRepository.new
# album = repo.find(1)
# p album.id
# p album.title