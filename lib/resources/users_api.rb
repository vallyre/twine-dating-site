require 'sinatra'
require_relative '../models/user'

database_config = ENV['DATABASE_URL']

if database_config.blank?
  database_config = YAML::load(File.open('config/database.yml'))
end

ActiveRecord::Base.establish_connection(database_config)

after do
  ActiveRecord::Base.connection.close
end

get '/api/users' do
  users = User.all

  gender = params[:gender]
  unless gender.blank?
    users = users.where(gender: gender)
  end

  users.to_json
end

get '/api/users/:id' do |id|
  user = User.find_by_id(id)

  halt 404 if user.nil?

  user.to_json
end

get '/api/users/:id/crushes'
  user = User.find_by_id(id)
  crushes = user.crushes
  crushes.to_json
end

post '/api/users' do
  user = User.new(first_name: params[:first_name], last_name: params[:last_name], age: params[:age], gender: params[:gender], image: params[:image])

  if user.valid?
    user.save
    [201, user.to_json]
  else
    status 400
  end
end
