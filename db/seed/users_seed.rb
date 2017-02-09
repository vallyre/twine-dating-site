require 'csv'
require_relative '../../lib/models/user'
require 'active_record'

database_config = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(database_config)

def main
  CSV.readlines('data/randomusers.csv', headers: true).each do |row|
    gender = row[0]
    first_name = row[1]
    last_name = row[2]
    dob = row[3]
    image = row[4]

    user = User.create(name: "#{first_name} #{last_name}", dob: dob, gender: gender, image: image)
  end
end

main if __FILE__ == $PROGRAM_NAME
