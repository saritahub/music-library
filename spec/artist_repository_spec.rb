require '/Users/saritaradia/Desktop/Projects/music-library/lib/artist_repository.rb'

RSpec.describe ArtistRepository do
  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

    before(:each) do
      reset_artists_table
    end

    # (your tests will go here).


  it "Gets all artist records " do
    repo = ArtistRepository.new
    artists = repo.all
    expect(artists.length).to eq(2)
    expect(artists.first.id).to eq ('1')
    expect(artists.first.name).to eq ('Pixies')
  end

  it 'returns a single artist' do
    repo = ArtistRepository.new
    artist = repo.find(1)
    expect(artist.id).to eq('1')
    expect(artist.name).to eq('Pixies')
    expect(artist.genre).to eq('Rock')
  end

  it 'returns another single artist' do
    repo = ArtistRepository.new
    artist = repo.find(2)
    expect(artist.id).to eq('2')
    expect(artist.name).to eq('ABBA')
    expect(artist.genre).to eq('Pop')
  end

  context "create new artists" do
    it "adds a new artist" do
      repo = ArtistRepository.new
      new_artist = Artist.new
      new_artist.name = 'Beatles'
      new_artist.genre = 'Pop'

      repo.create(new_artist) # => nil
      #Then check if the last artist is the one we have just added
      artists = repo.all
      last_artist = artists.last
      expect(last_artist.name).to eq('Beatles')
      expect(last_artist.genre).to eq('Pop')
    end
  end

  context "it deletes an artist" do
    it "deletes one artist" do
      repo = ArtistRepository.new
      id_to_delete = 1
      repo.delete(id_to_delete)

      all_artists = repo.all
      expect(all_artists.length).to eq(1)
      expect(all_artists.first.id).to eq('2')
    end

    it "deletes two artists" do
      repo = ArtistRepository.new
      repo.delete(1)
      repo.delete(2)

      all_artists = repo.all
      expect(all_artists.length).to eq(0)
    end
  end

  context "it updates artist with new values" do
    it "updates one artist" do
      #5 Update an artist
      repo = ArtistRepository.new
      artist = repo.find(1)
      artist.name = 'Something else'
      artist.genre = 'Disco'
      repo.update(artist)

      updated_artist = repo.find(1)

      expect(updated_artist.name).to eq('Something else')
      expect(updated_artist.genre).to eq('Disco')
    end

    it "updates one artist name but not genre" do
      #5 Update an artist
      repo = ArtistRepository.new
      artist = repo.find(1)
      artist.name = 'Something else'
      repo.update(artist)

      updated_artist = repo.find(1)

      expect(updated_artist.name).to eq('Something else')
      expect(updated_artist.genre).to eq('Rock')
    end
  end

end