class CreateGarbages < ActiveRecord::Migration[6.0]
  def change
    create_table :garbages do |t|
      t.string :description
      t.references :user
      t.string :points
      t.integer :status
      t.string :image
      t.timestamps
    end
  end
end
