require_relative '../lib/resources/likes_api'
require_relative '../config/test_environment'
require 'rspec'
require 'sinatra'
require 'rack/test'
require 'pry'

describe 'api' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
  describe Like do
    describe '#put api/users/:id/likes/:crush_id' do
      context 'when a valid id is input for a user and their crush' do
        it 'creates a like with that user id and crush id' do
          put 'api/users/1/likes/3'

          user = User.find_by_id(1)
          crushes = user.crushes
          ids = crushes.map { |u| u.id }

          expect(ids.include? 3).to eq true
        end
      end
    end
  end
end
