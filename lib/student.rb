class Student 
attr_reader :id
attr_accessor :name, :grade

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end


  # class method that creates the students table.
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY, 
      name TEXT, 
      grade TEXT
    )
    SQL
    DB[:conn].execute(sql) 
  end

#   #class method that drops the students table
  def self.drop_table
    sql = <<-SQL 
    DROP TABLE students
    SQL
    DB[:conn].execute(sql) 
  end

 
  #instance method that saves the attributes describing a given student to the students table in our database
  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) 
    VALUES(?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  #class method that instantiates a new Student object and save that new student - returning a student object that it creates.
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end



#   Remember, you can access your database connection anywhere in this class
#    with DB[:conn]  
  
end
