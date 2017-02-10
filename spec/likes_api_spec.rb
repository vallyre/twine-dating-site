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

  before :all do
    conn = PG::Connection.open(:dbname => 'dating_site_test')
    conn.exec("TRUNCATE TABLE likes")
    conn.close
  end

  describe Like do
    describe '#post api/users/:id/likes/:crush_id' do
      context 'when a valid id is input for a user and their crush' do
        it 'creates a like with that user id and crush id' do
          post 'api/users/1/likes/3'

          user = User.find_by_id(1)
          crushes = user.crushes
          ids = crushes.map { |u| u.id }

          expect(ids.include? 3).to eq true
          expect(last_response.status).to eq 201
        end
      end

      context 'when an invalid id is input for a user or a crush' do
        it 'returns a 404 status' do
          post 'api/users/2000/likes/3'

          expect(last_response.status).to eq 404
        end
      end
    end
  end
end
