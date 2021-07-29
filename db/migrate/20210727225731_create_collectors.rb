class CreateCollectors < ActiveRecord::Migration[6.1]
  def change
    create_table :collectors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :full_address
      t.string :phone_num
    end
  end
end
