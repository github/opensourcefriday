class CleanupUsersColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :github_uid, :string
    remove_column :users, :github_name, :string
    remove_column :users, :email, :string, null: false, default: ""
    remove_column :users, :subscribed_to_newsletter, :bool, default: false
    add_index :users, :github_username
  end
end
