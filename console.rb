require('pry')
require_relative('./models/student')
require_relative('./models/house')

House.delete_all()
Student.delete_all()

griffindor = House.new({'name' => 'Griffindor',
                        'logo' => 'http://www.griffindor.com'})
griffindor.save()

slytherin = House.new({'name' => 'Slytherin',
                       'logo' => 'http://www.slytherin.com'})
slytherin.save()

hufflepuff = House.new({'name' => 'Hufflepuff',
                        'logo' => 'http://www.hufflepuff.com'})
hufflepuff.save()

ravenclaw = House.new({'name' => 'Ravenclaw',
                      'logo' => 'http://www.hufflepuff.com'})
ravenclaw.save()

student1 = Student.new({'first_name' => 'Harry',
                        'last_name' => 'Potter',
                        'house_id' => griffindor.id,
                        'age' => 14})
student1.save()

student2 = Student.new({'first_name' => 'Hermione',
                        'last_name' => 'Granger',
                        'house_id' => griffindor.id,
                        'age' => 14})
student2.save()

student3 = Student.new({'first_name' => 'Draco',
                        'last_name' => 'Malfoy',
                        'house_id' => slytherin.id,
                        'age' => 15})
student3.save()



binding.pry
nil
