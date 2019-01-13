class AddAssignedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :assigned, :boolean, default: false, null: false
  end
end
