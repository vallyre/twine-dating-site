class CreateLikes < ActiveRecord::Migration[5.0]
  def up
    create_table :likes do |t|
      t.references :user, references: :users
      t.references :crush, references: :users

      t.timestamps
    end

    add_foreign_key :likes, :users, column: :user_id
    add_foreign_key :likes, :users, column: :crush_id
  end

  def down
    drop_table :likes
  end
end
