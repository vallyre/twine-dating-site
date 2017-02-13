require 'sinatra'
require_relative '../models/user'
require_relative '../models/like'

database_config = ENV['DATABASE_URL']

if database_config.blank?
  database_config = YAML::load(File.open('config/database.yml'))
end

ActiveRecord::Base.establish_connection(database_config)

after do
  ActiveRecord::Base.connection.close
end

#Get all users
#Optional: filter by gender (e.g. /api/users?gender=male)
#Optional: select number of results (e.g. /api/users?gender=female&results=10, /api/users?results=100, etc.)
#Optional: get last users id by position (e.g. /api/users?position=last)

get '/' do
  File.read(File.join('public', 'index.html'))
end


get '/api/users' do
  users = User.all

  gender = params[:gender]
  unless gender.blank?
    users = users.where(gender: gender)
  end

  results = params[:results].to_i
  if results > 0
    users = users.sample(results)
  end

  position = params[:position]
  if position == 'last'
    users = users.last
  end

  users.to_json
end

#Get a specific user by their id
get '/api/users/:id' do |id|
  user = User.find_by_id(id)

  halt(404, { message:'Invalid id'}.to_json) if user.nil?

  user.to_json
end

#Get crushes of a specific user
get '/api/users/:id/crushes' do |id|
  user = User.find_by_id(id)

  halt(404, { message:'Invalid id'}.to_json) if user.nil?

  crushes = user.crushes
  crushes.to_json
end

#Create a new user
post '/api/users' do
  user = User.new(name: params[:name], dob: params[:dob], gender: params[:gender], image: params[:image])

  if user.valid?
    user.save
    [201, user.to_json]
  else
    status 400
  end
end

delete '/api/users/:id' do |id|
  user = User.find_by_id(id)
  if user.nil?
    status 404
  else
    user.destroy
  end
end
