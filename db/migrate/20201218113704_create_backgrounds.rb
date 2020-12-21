class CreateBackgrounds < ActiveRecord::Migration[6.1]
  def change
    create_table :backgrounds do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :tags
      t.string :categories, null: false
      t.integer :likes, :default => 0 #default: 0
      
      t.timestamps
    end
  end
end
