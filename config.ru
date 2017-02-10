# Dir["lib/resources/*.rb"].each { |file| require file }
require_relative 'lib/resources/likes_api'
require_relative 'lib/resources/users_api'

run Sinatra::Application
