class SwitchToRaceId < ActiveRecord::Migration
  def change
    remove_column :vault_hunters, :race
    add_column :vault_hunters, :race_id, :integer
  end
end
