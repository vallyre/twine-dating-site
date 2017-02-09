require 'sinatra'
require_relative '../models/user'

post '/api/user' do
  user = User.new(first_name: params[:first_name], last_name: params[:last_name], age: params[:age], image: params[:image])

  if user.valid?
    user.save
    [201, user.to_json]
  else
    status 400
  end
end

get '/api/user' do
  users = User.all

  gender = params[:gender]
  unless gender.blank?
    users = users.where(gender: gender)
  end

  users.to_json
end

get '/api/user/:id' do |id|
  user = User.find_by_id(id)

  halt 404 if user.nil?

  user.to_json
end
