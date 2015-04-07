class AddCurrentToArmorInstance < ActiveRecord::Migration
  def change
    change_table :armor_instances do |t|
      t.column :current_deflect, :integer
    end
  end
end
