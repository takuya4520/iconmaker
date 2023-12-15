class CreateStories < ActiveRecord::Migration[7.1]
  def change
    create_table :stories do |t|
      t.string :plan
      t.text :content

      t.timestamps
    end
  end
end
