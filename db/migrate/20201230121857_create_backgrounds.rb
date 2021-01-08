class CreateBackgrounds < ActiveRecord::Migration[6.1]
  def change
    create_table :backgrounds do |t|
      t.string :title
      t.string :path
      t.string :tags
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
