require_relative '../lib/models/user'
require_relative '../lib/models/like'
require_relative '../config/test_environment'
require 'rspec'
require 'pry'

describe User do
  describe '#crushes' do
    before do
      conn = PG::Connection.open(:dbname => 'dating_site_test')
      conn.exec("TRUNCATE TABLE likes")
      Like.create(user_id: 1, crush_id: 2)
      conn.close
    end

    context 'when called on a user' do
      it 'returns an array of that users crushes' do
        user = User.find_by_id(1)

        crushes = user.crushes

        expect(crushes.first['id']).to eq 2
      end
    end
  end
end
