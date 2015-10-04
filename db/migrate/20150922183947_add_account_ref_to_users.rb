class AddAccountRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :account, index: true, polymorphic: true
  end
end
