require 'activerecord'

class User < ActiveRecord::Base
  validates :first_name, :last_name, :state, :gender_pref, :gender, presence: true
  validates :age numericality { only_integer: true }
  belongs_to :person
end
