class AddSpeedToMinionTemplates < ActiveRecord::Migration
  def change
    change_table :minion_templates do |t|
      t.column :speed, :integer
    end
  end
end
