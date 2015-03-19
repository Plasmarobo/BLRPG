class AddDepleteEffectToShieldTemplates < ActiveRecord::Migration
  def change
    change_table :shield_templates do |t|
      t.column :deplete_effect_id, :integer
    end
  end
end
