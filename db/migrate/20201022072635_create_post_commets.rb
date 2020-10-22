class CreatePostCommets < ActiveRecord::Migration[5.2]
  def change
    create_table :post_commets do |t|
      t.text :comment
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
