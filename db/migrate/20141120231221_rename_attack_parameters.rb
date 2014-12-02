class RenameAttackParameters < ActiveRecord::Migration
  def change
    rename_column :attacks, :pool, :totalpool
    rename_column :attacks, :base_pool, :basepool
    rename_column :attacks, :misc_pool, :otherpool
  end
end
