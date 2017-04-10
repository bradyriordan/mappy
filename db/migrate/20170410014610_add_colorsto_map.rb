class AddColorstoMap < ActiveRecord::Migration
  def change
  add_column :maps, :background_color, :string
  add_column :maps, :node_background_color, :string
  add_column :maps, :node_stroke_color, :string
  end
end
