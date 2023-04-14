class AddNotNullConstraintToFlowersColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_null :flowers, :address, false
    change_column_null :flowers, :latitude, false
    change_column_null :flowers, :longitude, false
  end
end
