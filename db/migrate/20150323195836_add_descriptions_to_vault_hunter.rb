class AddDescriptionsToVaultHunter < ActiveRecord::Migration
  def change
    change_table :vault_hunters do |t|
      t.column :eyes, :string
      t.column :hair, :string
      t.column :skin, :string
    end
  end
end
