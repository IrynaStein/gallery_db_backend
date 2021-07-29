class CreateArtworks < ActiveRecord::Migration[6.1]
  def change
    create_table :artworks do |t|
      t.string :title
      t.integer :edition
      t.integer :likes
      t.float :price
      t.text :medium
      t.text :image
      t.boolean :featured
      t.integer :date_created
      t.integer :category_id
    end
  end
end
