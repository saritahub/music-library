require '/Users/saritaradia/Desktop/Projects/music-library/lib/cohort.rb'
class CohortRepository

  def all
    sql = 'SELECT id, name, start_date FROM cohorts;'
    params = []
    result = DatabaseConnection.exec_params(sql, params)


    cohorts = []

    result.each do |record|
      cohort = Cohort.new
      cohort.id = record['id']
      cohort.name = record['name']
      cohort.start_date = record['start_date']
      cohorts << cohort
    end
    return cohorts

  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # sql = 'SELECT id, name, start_date FROM students WHERE id = $1;'

    # Returns a single Student object.
  end

  def find_with_students(id)

  end
end