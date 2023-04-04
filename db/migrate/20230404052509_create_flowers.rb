class CreateFlowers < ActiveRecord::Migration[6.1]
  def change
    create_table :flowers do |t|
      t.string :name
      t.text :description
      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      
      t.timestamps
    end
  end
end
