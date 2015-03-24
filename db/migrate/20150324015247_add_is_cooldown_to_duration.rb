class AddIsCooldownToDuration < ActiveRecord::Migration
  def change
    change_table :durations do |t|
      t.column :is_cooldown, :boolean
    end
  end
end
