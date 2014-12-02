class RenameAttributeIdAttributeInstanceId < ActiveRecord::Migration
  def change
    rename_column :attacks, :attribute_id, :attribute_instance_id
  end
end
