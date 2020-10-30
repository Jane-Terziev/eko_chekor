class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.decimal :longitude
      t.decimal :latitude
      t.integer :locationable_id
      t.string :locationable_type
    end
  end
end
