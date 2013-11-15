class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
   # add the following after the migration of remember_token
   # rails generate migration add_remember_token_to_users
   # after adding below code run
   # bundle exec rake db:migrate
   # bundle exec rake test:prepare
   add_column :users, :remember_token, :string
   add_index  :users, :remember_token
  end
end
