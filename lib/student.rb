class Student
  attr_accessor :id, :name, :grade
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.new_from_db(row)
    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
  end

  def self.all
    sql = <<-SQL
      SELECT * FROM students
    SQL
    
    DB[:conn].execute(sql).map {|row| self.new_from_db(row)}
  end

  def self.find_by_name(student_name)
    sql = <<-SQL
      SELECT * FROM students
      WHERE name = ?
    SQL
    
    DB[:conn].execute(sql, student_name).map do |row|
      self.new_from_db(row)
    end.first
  end
  
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

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  
  def self.all_students_in_grade_9
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = ?
    SQL
    
    DB[:conn].execute(sql, 9).map do |row|
      self.new_from_db(row)
    end
  end
  
  def self.students_below_12th_grade
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade < ?
    SQL
    
    DB[:conn].execute(sql, 12).map do |row|
      self.new_from_db(row)
    end
  end
  
  def self.first_X_students_in_grade_10(x)
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = ?
      LIMIT ?
    SQL
    
    DB[:conn].execute(sql, 10, x).map do |row|
      self.new_from_db(row)
    end
  end
  
  def self.first_student_in_grade_10
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = ?
    SQL
    
    DB[:conn].execute(sql, 10).map do |row|
      self.new_from_db(row)
    end.first
  end
  
  def self.all_students_in_grade_X(x)
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = ?
    SQL
    
    DB[:conn].execute(sql, x).map do |row|
      self.new_from_db(row)
    end
  end
end