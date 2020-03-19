require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/pill')
require_relative('../models/user')
require_relative('../models/taken')

also_reload('../models/*')

get '/pills' do
  @pills = Pill.all
  erb(:"pills/index")
end

get '/pills/add' do
  erb(:"pills/new")
end

get '/pills/:id' do
  @pill = Pill.find(params['id'])
  erb(:"pills/show")
end

get '/pills/:id/edit' do
  @pill = Pill.find(params['id'])
  erb (:"pills/edit")
end

post '/pills' do
  @pill = Pill.new( params )
  @pill.save()
  erb( :"pills/create" )
end

post '/pills/:id' do
  pill = Pill.new(params)
  pill.update
  redirect to "/pills/#{params['id']}"
end
