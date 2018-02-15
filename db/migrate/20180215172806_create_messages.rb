class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :content, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end

    # Add an index to increase performance on queries
    def up
    	add_index :latitude, :longitude
    end

    # Remove the index case this table is removed
    def down
    	remove_index :latitude, :longitude
    end
  end
end
