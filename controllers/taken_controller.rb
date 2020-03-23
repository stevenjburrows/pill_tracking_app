require('sinatra')
# require('sinatra/contrib/all')
require_relative('../models/user')
require_relative('../models/pill')
require_relative('../models/taken')

# also_reload('../models/*')


post '/taken' do
  @taken = Taken.new( params )
  @taken.save()
  redirect to ("/users")
end
