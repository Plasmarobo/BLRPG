class CreateDurations < ActiveRecord::Migration
  def change
    create_table :durations do |t|
      t.integer :max_time
      t.integer :current_time
      t.integer :skill_id

      t.timestamps
    end
  end
end
