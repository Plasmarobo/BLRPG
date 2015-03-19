class AddInUseToArmorInstances < ActiveRecord::Migration
  def change
    change_table :armor_instances do |t|
      t.column :in_use, :boolean
    end
  end
end
