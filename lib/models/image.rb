require 'activerecord'

class Image < ActiveRecord::Base
  validates :name
  belongs_to :person
end
