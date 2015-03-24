class AddValueToProficiency < ActiveRecord::Migration
  def change
    change_table :proficiency_instances do |t|
      t.column :value, :integer
    end
  end
end
