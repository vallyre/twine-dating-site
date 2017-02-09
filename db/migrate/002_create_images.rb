require 'activerecord'

class CreateImages < ActiveRecord::Migration[5.0]
    def up
     create_table :images do |t|
        t.string :description
        t.string :content_type
        t.string :filename
        t.binary :binary_data
        t.belongs_to :user, :foreign_key => 'users.id'
     end

  def down
     drop_table :images
  end
end
