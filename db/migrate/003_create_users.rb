class CreateUser < ActiveRecord::Migration[5.0]
  def up
    create_table :user do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :state
      t.string :gender_pref
      t.string :gender
      t.string :likes, array: true, default: []

      t.timestamps
    end
  end

  def down
    drop_table :user
  end
end
