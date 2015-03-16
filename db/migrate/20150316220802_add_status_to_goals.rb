class AddStatusToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :status, :string, null: false, default: 'in progress'
  end
end
