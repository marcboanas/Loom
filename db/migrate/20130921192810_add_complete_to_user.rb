class AddCompleteToUser < ActiveRecord::Migration
  def change
    add_column :users, :complete, :boolean
  end
end
