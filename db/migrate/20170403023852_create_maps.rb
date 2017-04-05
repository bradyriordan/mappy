class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.text :name
      t.string :content

      t.timestamps null: false
    end
  end
end
