class AddCateogryToProficiencies < ActiveRecord::Migration
  def change
    change_table :proficiency_templates do |t|
      t.column :category, :string
    end
  end
end
