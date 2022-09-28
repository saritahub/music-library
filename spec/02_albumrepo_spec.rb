require '/Users/saritaradia/Desktop/Projects/music-library/lib/02_albumsrepo.rb'

RSpec.describe AlbumRepository do
  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  describe AlbumRepository do
    before(:each) do
      reset_albums_table
    end

  it "Gets all albums" do
    repo = AlbumRepository.new
    album = repo.all
    expect(album.length).to eq(1)
    expect(album[0].id).to eq('1')
    expect(album[0].title).to eq('Girl of My Dreams')
    expect(album[0].release_year).to eq '2022'
    expect(album[0].artist_id).to eq('8')
  end

    it "returns single album" do
      repo = AlbumRepository.new
      album = repo.find(1)
      expect(album.title).to eq('Girl of My Dreams')
      expect(album.release_year).to eq('2022')
      expect(album.artist_id).to eq('8')
    end

  end
end