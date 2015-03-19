class CreateStackInstances < ActiveRecord::Migration
  def change
    create_table :stack_instances do |t|
      t.integer :stack_template_id
      t.integer :current_pool
      t.integer :max_pool

      t.timestamps
    end
  end
end
