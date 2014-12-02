class AddFormulaToAttacks < ActiveRecord::Migration
  def change
    add_column :attacks, :base_pool, :integer
    add_column :attacks, :attribute_id, :integer
    add_column :attacks, :misc_pool, :integer
  end
end
