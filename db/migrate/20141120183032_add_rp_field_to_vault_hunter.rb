class AddRpFieldToVaultHunter < ActiveRecord::Migration
  def change
    add_column :vault_hunters, :description, :text
    add_column :vault_hunters, :background, :text
    add_column :vault_hunters, :traits, :text
    add_column :vault_hunters, :flaws, :text
    add_column :vault_hunters, :minions, :text
  end
end
