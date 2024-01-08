class AddImageToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :icon, :string
  end
end
