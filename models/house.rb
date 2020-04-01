require_relative('../db/sql_runner')

class House

  attr_accessor :name, :logo
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @logo = options['logo']
  end

  # def get_house_name()
  #   return "#{@name}"
  # end

  def save()
    sql = "INSERT INTO houses (name, logo)
           VALUES ($1, $2)
           RETURNING id"
    values = [@name, @logo]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def House.find(id)
    sql = "SELECT * FROM houses WHERE id = $1"
    values = [id]
    house = SqlRunner.run(sql, values).first()
    return nil if house == nil
    return House.new(house)
  end

  def House.all()
    sql = "SELECT * FROM houses"
    houses = SqlRunner.run(sql)
    return houses.map {|house| House.new(house)}
  end

  def House.delete_all()
    sql = "DELETE FROM houses"
    SqlRunner.run(sql)
  end

end
