require '/Users/saritaradia/Desktop/Projects/music-library/app.rb'

RSpec.describe Application do
    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end
    
    def reset_artists_table
        seed_sql = File.read('spec/seeds_artists.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

  before(:each) do
    reset_albums_table
    reset_artists_table
  end

    it "When user input is 1, it lists all albums" do
      io = double :terminal_io
      expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
      expect(io).to receive(:puts).with("What would you like to do?").ordered
      expect(io).to receive(:puts).with("1 - List all albums").ordered
      expect(io).to receive(:puts).with("2 - List all artists").ordered
      expect(io).to receive(:print).with("Enter your choice:").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("1 - Pixies").ordered
      expect(io).to receive(:puts).with("2 - ABBA").ordered

      list_albums = Application.new('music_library_test', io, AlbumRepository.new, ArtistRepository.new)
      list_albums.run

    end

    it "When user input is 2, it lists all artists" do
      io = double :terminal_io
      expect(io).to receive(:puts).with("Welcome to the music library manager!").ordered
      expect(io).to receive(:puts).with("What would you like to do?").ordered
      expect(io).to receive(:puts).with("1 - List all albums").ordered
      expect(io).to receive(:puts).with("2 - List all artists").ordered
      expect(io).to receive(:print).with("Enter your choice:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("1 - Girl of My Dreams").ordered

      list_albums = Application.new('music_library_test', io, AlbumRepository.new, ArtistRepository.new)
      list_albums.run
    end

end


