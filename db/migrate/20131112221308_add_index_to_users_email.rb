class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
   #you need to fill in the line below
   add_index :users, :email, unique: true
  end
end
