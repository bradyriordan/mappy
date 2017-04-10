class AddIsPublicToMaps < ActiveRecord::Migration
  def change
	add_column :maps, :is_public, :boolean
  end
end
