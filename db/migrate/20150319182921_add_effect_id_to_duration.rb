class AddEffectIdToDuration < ActiveRecord::Migration
  def change
    change_table :durations do |t|
      t.column :effect_id, :integer
    end
  end
end
