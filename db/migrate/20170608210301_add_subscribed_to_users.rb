class AddSubscribedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscribed_to_newsletter, :bool, :default => false
  end
end
