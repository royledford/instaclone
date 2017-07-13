class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :picture_path
      t.string :post_text
      t.integer :view_count

      t.timestamps
    end
  end
end
