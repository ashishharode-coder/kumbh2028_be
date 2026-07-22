class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :comments }

      t.text :content
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :comments, :deleted_at
  end
end
