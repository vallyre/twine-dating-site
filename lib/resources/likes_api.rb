require 'sinatra'
require_relative '../models/like'
require_relative '../models/user'

database_config = ENV['DATABASE_URL']

if database_config.blank?
  database_config = YAML::load(File.open('config/database.yml'))
end

ActiveRecord::Base.establish_connection(database_config)

after do
  ActiveRecord::Base.connection.close
end

put '/api/users/:id/likes/:crush_id' do |id, crush_id|
  Like.create(user_id: id, crush_id: crush_id)
end
