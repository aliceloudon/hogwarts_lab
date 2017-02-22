require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('./models/student.rb')

get '/students' do
  @students = Student.all
  erb(:index)
end

get '/students/new' do
  erb(:new)
end

