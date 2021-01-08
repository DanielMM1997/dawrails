class CreateBackgroundCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :background_categories do |t|
      t.belongs_to :background, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
