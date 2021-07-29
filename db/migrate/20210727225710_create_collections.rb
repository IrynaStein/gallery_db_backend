class CreateCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :collections do |t|
      t.integer :artwork_id
      t.integer :collector_id
    end
  end
end
