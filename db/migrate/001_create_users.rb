class CreateUser < ActiveRecord::Migration[5.0]

  def up
    create_table :user do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :gender
      t.string :image
      
      t.timestamps
    end
  end

  def down
    drop_table :user
  end
end
