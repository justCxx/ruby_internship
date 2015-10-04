class CreateShopOwners < ActiveRecord::Migration
  def change
    create_table :shop_owners do |t|
      t.string :shop_name

      t.timestamps null: false
    end
  end
end
