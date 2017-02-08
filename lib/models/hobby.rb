require 'activerecord'

class Hobby < ActiveRecord::Base
  validates :name
  belongs_to :person
end
