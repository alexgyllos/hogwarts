require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('./models/student')
also_reload('./models/*')

# INDEX

get '/students' do
  @students = Student.all()
  erb(:index)
end

# NEW

get '/students/new' do
  @houses = House.all()
  @students = Student.all()
  erb(:new)
end

# EDIT

get '/students/:id/edit' do
  id = params['id'].to_i
  @students = Student.find(id)
  @houses = House.all()
  erb(:edit)
end

# SHOW

get '/students/:id' do
  id = params['id'].to_i()
  @student = Student.find(id)
  erb(:show)
end

# CREATE

post '/students' do
  new_student = Student.new(params)
  new_student.save()
  erb(:create)
end

# DELETE

post '/students/:id/delete' do
  id = params['id'].to_i()
  student = Student.find(id)
  student.delete()
  redirect('/students')
end

# EDIT

post '/students/:id' do
  updated_student = Student.new(params)
  updated_student.update()
  redirect('/students/' + params['id'])
end
