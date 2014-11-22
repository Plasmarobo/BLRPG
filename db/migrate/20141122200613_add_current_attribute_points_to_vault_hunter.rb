class AddCurrentAttributePointsToVaultHunter < ActiveRecord::Migration
  def change
    add_column :vault_hunters, :current_attribute_points, :integer
  end
end
