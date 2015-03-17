class AddBodyToComments < ActiveRecord::Migration
  def change
    add_column :comments, :body, :text, null: false, default: ''
  end
end
