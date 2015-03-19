class CreateEffects < ActiveRecord::Migration
  def change
    create_table :effects do |t|
      t.string :name
      t.text :description
      t.integer :modifier_id
      t.integer :duration

      t.timestamps
    end
  end
end
