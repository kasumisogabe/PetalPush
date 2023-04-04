class AddUserRefToFlowers < ActiveRecord::Migration[6.1]
  def change
    add_reference :flowers, :user, null: false, foreign_key: true
  end
end
