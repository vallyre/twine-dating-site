require 'active_record'

class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :crush, :class_name => "User"
end
