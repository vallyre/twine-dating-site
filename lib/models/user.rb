require 'active_record'
require_relative 'like'

class User < ActiveRecord::Base
  validates :name, :dob, presence: true
  # validates_format_of :dob, :with => /\d+\/\d+\/\d+/
  validates :gender, inclusion: { in: ['male', 'female'] }
  validates :image, presence: true
  has_many :likes

  def crushes
    self.likes.map { |like| like.crush }
  end
end
