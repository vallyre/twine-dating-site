require 'active_record'
require 'pg'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  host:     'localhost',
  database: 'dating_site_test',
  username: 'Brentice',
  password: ''
)
