require_relative('../db/sql_runner')
require_relative('./house')

class Student

  attr_accessor :first_name, :last_name, :house_id, :age
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @house_id = options['house_id'].to_i
    @age = options['age']
  end

  def save()
  sql = "INSERT INTO students (first_name, last_name, house_id, age)
         VALUES ($1, $2, $3, $4) RETURNING id"
  values = [@first_name, @last_name, @house_id, @age]
  @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def full_name()
    return "#{@first_name} #{@last_name}"
  end

  def house_name()
    sql = "SELECT * FROM houses
           INNER JOIN students
           ON students.house_id = houses.id
           WHERE houses.id = $1 "
    values = [@house_id]
    house = SqlRunner.run(sql, values).first()
    # return nil if house == nil
    return house["name"]
  end

  def update()
    sql = "UPDATE students SET (first_name, last_name, house_id, age) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@first_name, @last_name, @house_id, @age, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM students WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Student.all_house_names()
    sql = "SELECT * FROM houses"
    result = SqlRunner.run(sql)
    return result.map {|house| House.new(house)}
  end

  def Student.find(id)
    sql = "SELECT * FROM students WHERE id = $1"
    values = [id]
    student = SqlRunner.run(sql, values).first()
    return nil if student == nil
    return Student.new(student)
  end

  def Student.all()
    sql = "SELECT * FROM students"
    results = SqlRunner.run(sql)
    return results.map {|student| Student.new(student)}
  end

  def Student.delete_all()
    sql = "DELETE FROM students"
    SqlRunner.run(sql)
  end

end
