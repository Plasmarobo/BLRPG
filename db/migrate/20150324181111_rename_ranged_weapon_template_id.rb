class RenameRangedWeaponTemplateId < ActiveRecord::Migration
  def change
    change_table :weapon_instances do |t|
      t.rename :ranged_weapon_template_id, :weapon_template_id
    end
  end
end
