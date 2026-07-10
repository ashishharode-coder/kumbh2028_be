class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.integer :post_type
      t.integer :status
      t.integer :priority
      t.string :location
      t.datetime :published_at
      t.boolean :verified

      t.timestamps
    end
  end
end
