class DropPrerequsites < ActiveRecord::Migration
  def change
    drop_table :prerequsites
  end
end
