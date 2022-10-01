class Cohort

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :start_date

  def initialize
    @students = []
  end
end