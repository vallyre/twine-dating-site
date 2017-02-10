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

post '/api/users/:id/likes/:crush_id' do |id, crush_id|
  user = User.find_by_id(id)
  crush = User.find_by_id(crush_id)

  halt(404, { message:'Invalid id'}.to_json) if (user.nil? || crush.nil?)

  like = Like.create(user_id: id, crush_id: crush_id)

  [201, like.to_json]
end
