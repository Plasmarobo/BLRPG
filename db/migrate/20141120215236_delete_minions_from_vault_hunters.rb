class DeleteMinionsFromVaultHunters < ActiveRecord::Migration
  def change
    remove_column :vault_hunters, :minions
  end
end
