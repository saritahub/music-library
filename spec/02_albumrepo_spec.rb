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

  context "it creates a new album" do
    it "creates a new album" do
    repository = AlbumRepository.new

    new_album = Album.new
    new_album.title = 'Expectations'
    new_album.release_year = 2018
    new_album.artist_id = 1

    repository.create(new_album)

    albums = repository.all
    last_album = albums.last
    expect(last_album.title).to eq('Expectations')
    expect(last_album.release_year).to eq('2018')
    expect(last_album.artist_id).to eq('1')

    #ANOTHER WAY TO RUN THE ABOVE TEST
    expect(albums).to include(have_attributes(title: new_album.title, release_year: '2018'))


    # The all_albums array should contain the new Album object
    end
    end

end