class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.text :description
      t.integer :user_id, null: false, index: true
      t.string :privacy, null: false

      t.timestamps null: false
    end
  end
end
