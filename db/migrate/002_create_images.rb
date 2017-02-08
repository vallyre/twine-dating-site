require 'activerecord'

class CreateImages < ActiveRecord::Migration
  def up
   create_table :images do |t|
      t.column :content_type, :string
      t.column :filename, :string
      t.column :binary_data, :binary

      t.timestamps
   end

  def down
     drop_table :teams
  end
end
