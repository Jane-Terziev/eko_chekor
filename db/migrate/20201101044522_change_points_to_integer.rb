class ChangePointsToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :garbages, :points, :integer, using: 'points::integer'
  end
end
