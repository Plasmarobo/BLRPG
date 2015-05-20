class AddDefaultOfUnequipped < ActiveRecord::Migration
  def change
    change_column :armor_instances, :in_use, :boolean, default: false
    change_column :shield_instances, :in_use, :boolean, default: false
  end
end
