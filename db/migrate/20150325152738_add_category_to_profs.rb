class AddCategoryToProfs < ActiveRecord::Migration
  def change
    change_table :proficiency_instances do |t|
      t.column :category, :string
    end
  end
end
