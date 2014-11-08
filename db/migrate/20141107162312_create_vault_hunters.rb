class CreateVaultHunters < ActiveRecord::Migration
  def change
    create_table :vault_hunters do |t|
      t.string :name
      t.string :player
      t.integer :age
      t.string :race
      t.integer :heigh
      t.integer :weight
      t.integer :attributes_id
      t.integer :toughness
      t.integer :wounds
      t.integer :shield
      t.integer :current_shield
      t.integer :attacks_id
      t.text :loot
      t.integer :money
      t.integer :level
      t.integer :proficiencies_id
      t.integer :skills_id

      t.timestamps
    end
  end
end
