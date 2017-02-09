require 'active_record'
require_relative 'like'

class User < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 18 }
  validates :gender, inclusion: { in: ['male', 'female'] }
  validates :image, presence: true
  has_many :likes

  def crushes
    self.likes.map { |like| like.crush }
  end
end
