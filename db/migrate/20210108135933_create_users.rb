class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password
      t.integer :type, default: 3

      t.timestamps
    end
  end
end
