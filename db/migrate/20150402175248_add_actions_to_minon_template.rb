class AddActionsToMinonTemplate < ActiveRecord::Migration
  def change
    change_table :minion_templates do |t|
      t.column :actions, :string
    end
  end
end
