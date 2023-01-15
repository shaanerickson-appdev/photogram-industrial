class RemoveBooksCountFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :books_count, :integer
  end
end
