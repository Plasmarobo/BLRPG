class RenameModifiersToModifierInstances < ActiveRecord::Migration
  def change
    rename_table :modifiers, :modifier_instances
  end
end
