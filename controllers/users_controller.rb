require('sinatra')
# require('sinatra/contrib/all')

require_relative('../models/user')
require_relative('../models/pill')
require_relative('../models/taken')
require_relative('taken_controller')
# also_reload('../models/*')

get '/users' do
  @users = User.all
  erb(:"users/index")
end

get '/users/add' do
  erb(:"users/new")
end

get '/users/:id/take_pill' do
  @user = User.find(params['id'])
  @pills = Pill.all
  erb(:"taken/new")
end

get '/users/:id' do
  @user = User.find(params['id'])
  erb (:"users/show")
end

get '/users/:id/edit' do
  @user = User.find(params['id'])
  erb (:"users/edit")
end



post '/users' do
  @user = User.new( params )
  @user.save()
  erb( :"users/create" )
end

post '/users/:id' do
  user = User.new(params)
  user.update
  redirect to "/users/#{params['id']}"
end

post '/taken' do
  @taken = Taken.new( params )
  @taken.save()
  redirect to("/users")
end
