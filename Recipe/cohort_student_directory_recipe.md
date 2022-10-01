# Cohort Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: cohorts

Columns:
id | name | starting_date
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_cohorts.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (name, start_date) VALUES ('David', '2022-04-01');
INSERT INTO cohorts (name, start_date) VALUES ('David', '2022-09-01');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 student_directory_2 < seeds_cohorts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: cohorts

# Model class
# (in lib/cohort.rb)
class Cohort
end

# Repository class
# (in lib/cohortrepository.rb)
class CohortRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Cohort

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :start_date
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class CohortRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # sql = 'SELECT id, name, start_date FROM cohorts;'

    # Returns an array of Cohort objects.
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
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = CohortRepository.new

cohorts = repo.all

expect(cohorts.length).to eq(2)

expect(cohorts[0].id).to eq(1) 
expect(cohorts[0].name).to eq('Anne')
expect(cohorts.[0].start_date).to eq(2022-04-01)

expect(cohorts[1].id).to eq(2)
expect(cohorts[1].name).to eq('Sara')
expect(cohorts.[1].start_date).to eq(2022-09-01)

# 2
# Find single cohort

repo = CohortRepository.new

cohort = repo.find(1)

expect(cohort.id).to eq(1)
expect(cohorts.name).to eq('Anne')
expect(cohorts.start_date).to eq(2022-04-01)

# 3 Find_with_students 
it 'finds student 1 with related cohort' do
  repository = CohortRepository.new
  cohort = repository.find_with_students(1)

  expect(cohort.name).to eq('Anne')
  expect(cohort.students.length).to eq(2)
end

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._