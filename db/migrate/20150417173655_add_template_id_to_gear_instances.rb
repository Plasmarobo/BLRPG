class AddTemplateIdToGearInstances < ActiveRecord::Migration
  def change
    change_table :gear_instances do |t|
      t.column :gear_template_id, :integer
    end
  end
end
