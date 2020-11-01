class AddCleanerAndReviewerToGarbage < ActiveRecord::Migration[6.0]
  def change
    add_column :garbages, :cleaner_id, :integer
    add_column :garbages, :reviewer_id, :integer
    add_column :garbages, :image_cleaned, :string
    add_foreign_key :garbages, :users, column: :cleaner_id
    add_foreign_key :garbages, :users, column: :reviewer_id
  end
end
