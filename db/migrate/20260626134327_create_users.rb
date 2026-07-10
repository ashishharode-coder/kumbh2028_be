class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone, null: false
      t.string :email
      t.boolean :phone_verified, default: false
      t.datetime :last_login_at

      t.timestamps
    end

    add_index :users, :phone, unique: true
    add_index :users, :email, unique: true
  end
end
