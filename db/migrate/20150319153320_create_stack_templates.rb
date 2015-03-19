class CreateStackTemplates < ActiveRecord::Migration
  def change
    create_table :stack_templates do |t|
      t.string :name
      t.integer :default_pool
      t.integer :color
      t.string :icon

      t.timestamps
    end
  end
end
