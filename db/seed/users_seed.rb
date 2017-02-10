require 'csv'
require_relative '../../lib/models/user'
require 'active_record'

connection_details = ENV['DATABASE_URL']

if connection_details.blank?
  connection_details = YAML::load(File.open('config/database.yml'))
end

ActiveRecord::Base.establish_connection(connection_details)

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
