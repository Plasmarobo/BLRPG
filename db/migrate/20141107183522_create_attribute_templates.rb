class CreateAttributeTemplates < ActiveRecord::Migration
  def change
    create_table :attribute_templates do |t|
      t.string :name
      t.string :short

      t.timestamps
    end
  end
end
