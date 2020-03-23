require('sinatra')
# require('sinatra/contrib/all')
require_relative('models/pill')
require_relative('models/user')
require_relative('models/taken')
require_relative('controllers/pills_controller')
require_relative('controllers/users_controller')
require_relative('controllers/taken_controller')
# also_reload('./models/*')

get '/' do
  erb(:index)
end
