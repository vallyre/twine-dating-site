require_relative '../lib/resources/users_api'
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

  describe '#get /api/users' do
    context 'when nothing is entered' do
      it 'returns all users' do
        get '/api/users'

        expect(JSON.parse(last_response.body).length).to eq 861
      end
    end

    context 'when a gender is specified' do
      it 'returns all users of that gender' do
        get '/api/users?gender=female'

        expect(JSON.parse(last_response.body).first['gender']).to eq 'female'
        expect(JSON.parse(last_response.body).last['gender']).to eq 'female'
      end
    end

    context 'when number of results is entered' do
      it 'returns a random selection of that amount of users' do
        get '/api/users?results=10'

        expect(JSON.parse(last_response.body).length).to eq 10
      end
    end
  end

  describe '#get /api/users/:id' do
    context 'when a valid id is input' do
      it 'returs a user with that id' do
        get '/api/users/1'

        expect(JSON.parse(last_response.body)['id']).to eq 1
      end
    end

    context 'when an invalid id is input' do
      it 'returns 404' do
        get '/api/users/9020'

        expect(last_response.status).to eq 404
      end
    end
  end

  describe '#get /api/users/:id/crushes' do
    before do
      conn = PG::Connection.open(:dbname => 'dating_site_test')
      conn.exec("TRUNCATE TABLE likes")
      Like.create(user_id: 1, crush_id: 2)
      conn.close
    end

    context 'when a valid user id is input' do
      it 'returns that users crushes' do
        get '/api/users/1/crushes'

        expect(JSON.parse(last_response.body).first['id']).to eq 2
      end
    end

    context 'when an invalid user id is input' do
      it 'returns 404' do
        get 'api/users/4000/crushes'

        expect(last_response.status).to eq 404
      end
    end
  end

  describe '#post /api/users' do
    after do
      conn = PG::Connection.open(:dbname => 'dating_site_test')
      conn.exec("DELETE FROM users WHERE name='test tester'")
      conn.close
    end

    context 'when all parameters are input' do
      it 'adds user to database and returns 201' do
        post '/api/users?name=test tester&dob=6/29/88&gender=male&image=example.jpg'

        expect(JSON.parse(last_response.body)['name']).to eq 'test tester'
        expect(JSON.parse(last_response.body)['dob']).to eq '6/29/88'
        expect(last_response.status).to eq 201
      end
    end

    context 'when not all parameters are input' do
      it 'returns a 400 status' do
        post '/api/users?name=test tester'

        expect(last_response.status).to eq 400
      end
    end
  end
end
