require('time')
require('pry')
require_relative('../models/pill')
require_relative('../models/user')
require_relative('../models/taken')
user1 = User.new({'username' => 'Jason', 'age' => 36})
user1.save

pill1 = Pill.new({'name' => 'Paracetamol', 'type' => 'Painkillers', 'strength' => '500mg'})
pill1.save

time = Time.now

taken1 = Taken.new('user_id' => user1.id, 'pill_id' => pill1.id, 'quantity' => 2, 'time_taken' => time)
taken1.save
