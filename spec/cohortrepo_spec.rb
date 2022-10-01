require '/Users/saritaradia/Desktop/Projects/music-library/lib/CohortRepository.rb'
require '/Users/saritaradia/Desktop/Projects/music-library/lib/cohort.rb'

RSpec.describe CohortRepository  do
  def reset_cohorts_table
    seed_sql = File.read('spec/seeds_cohorts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
    connection.exec(seed_sql)
  end

    before(:each) do
      reset_cohorts_table
    end

  it "returns all cohorts" do
    repo = CohortRepository.new

    cohorts = repo.all

    expect(cohorts.length).to eq(2)
    #
    # expect(cohorts[0].id).to eq(1)
    # expect(cohorts[0].name).to eq('Anne')
    # # expect(cohorts[0].start_date).to eq(2022-04-01)
    #
    # expect(cohorts[1].id).to eq(2)
    # expect(cohorts[1].name).to eq('Sara')
    # expect(cohorts[1].start_date).to eq(2022-09-01)
  end
    end
