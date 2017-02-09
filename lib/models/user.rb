require 'active_record'

class User < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 18 }
  validates :gender, inclusion: { in: ['male', 'female'] }
  validates :image, presence: true
  has_many :crushes, :class_name => 'Like'
  has_many :received_like, :class_name => 'Like'
end
