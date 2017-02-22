require_relative('../db/sql_runner.rb')

class Student

  attr_reader :id
  attr_accessor :first_name, :last_name, :house, :age

  def initialize(options)
    @id = options['id'].to_i
    @first_name = options['first_name']
    @last_name = options['last_name']
    @house = options['house']
    @age = options['age'].to_i
  end

  def save
    sql = "INSERT INTO students (first_name, last_name, house, age) VALUES ('#{@first_name}', '#{@last_name}', '#{@house}', #{@age}) RETURNING *;"
    student = SqlRunner.run(sql).first
    @id = student['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM students"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM students"
    return self.get_many(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM students WHERE id = #{id}"
    student = SqlRunner.run(sql).first
    return student
  end

  def self.get_many(sql)
    students = SqlRunner.run(sql)
    result = students.map {|student| Student.new(student)}
    return result  
  end

end