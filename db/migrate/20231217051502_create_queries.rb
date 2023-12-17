class CreateQueries < ActiveRecord::Migration[7.1]
  def change
    create_table :queries do |t|
      t.string :query, :null => false

      t.timestamps
    end
  end
end
