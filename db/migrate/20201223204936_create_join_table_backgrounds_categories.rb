class CreateJoinTableBackgroundsCategories < ActiveRecord::Migration[6.1]
  def change
    create_join_table :backgrounds, :categories do |t|
      t.references :background, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
    end
  end
end
