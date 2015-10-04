class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthdate

      t.timestamps null: false
    end
  end
end
