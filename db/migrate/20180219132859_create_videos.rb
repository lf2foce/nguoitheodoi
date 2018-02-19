class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :link
      t.datetime :published_at
      t.integer :likes
      t.integer :dislikes
      t.string :uid

      t.timestamps
    end
    add_index :videos, :uid
  end
end
