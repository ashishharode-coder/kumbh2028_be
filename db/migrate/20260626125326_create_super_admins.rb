class CreateSuperAdmins < ActiveRecord::Migration[8.0]
  def change
    create_table :super_admins do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :super_admins, :email
  end
end
