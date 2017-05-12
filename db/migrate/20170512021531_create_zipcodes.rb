class CreateZipcodes < ActiveRecord::Migration[5.0]
  def change
    create_table :zipcodes do |t|
      t.integer :zipcode
      t.string :city
      t.string :state, length: 2
      t.decimal :lat, precision: 9, scale: 6
      t.decimal :lng, precision: 9, scale: 6
      t.integer :utc_offset
      t.boolean :dst

      t.timestamps
    end
    add_index :zipcodes, :zipcode
  end
end
