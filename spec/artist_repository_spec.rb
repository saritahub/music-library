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

end