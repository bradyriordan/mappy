class ChangeDataTypesMaps < ActiveRecord::Migration
  def change
	change_column :maps, :name, :string
	change_column :maps, :content, :text
  end
end
