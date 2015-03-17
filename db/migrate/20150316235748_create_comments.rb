class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      t.integer :author_id, null: false, index: true

      t.timestamps null: false
    end

    add_index :comments, [:commentable_id, :commentable_type]
  end
end
