class AddSecondaryDamageToWeapons < ActiveRecord::Migration
  def change
    change_table :weapon_templates do |t|
      t.column :secondary_damage, :integer
    end
  end
end
