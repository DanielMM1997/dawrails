class AddAuthorToBackground < ActiveRecord::Migration[6.1]
  def change
    add_reference :backgrounds, :author, references: :users, index: true
    add_foreign_key :backgrounds, :users, column: :author_id
  end
end
