class ChangeCooldownAndDurationToIds < ActiveRecord::Migration
  def change
    change_table :skill_instances do |t|
      t.rename :duration, :duration_id
      t.rename :cooldown, :cooldown_id
    end
  end
end
