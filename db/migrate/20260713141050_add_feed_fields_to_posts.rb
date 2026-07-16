class AddFeedFieldsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :likes_count,
               :integer,
               default: 0

    add_column :posts, :comments_count,
               :integer,
               default: 0

    add_column :posts, :shares_count,
               :integer,
               default: 0

    add_column :posts, :views_count,
               :integer,
               default: 0

    add_column :posts, :latitude,
               :decimal,
               precision: 10,
               scale: 7

    add_column :posts, :longitude,
               :decimal,
               precision: 10,
               scale: 7
  end
end
