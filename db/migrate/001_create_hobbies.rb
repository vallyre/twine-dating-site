class CreateHobbies < ActiveRecord::Migration[5.0]
    def up
     create_table :hobbies do |t|
        t.column :name, :string
        t.belongs_to :user, :foreign_key => 'users.id'
     end

  def down
     drop_table :hobbies
  end
end
