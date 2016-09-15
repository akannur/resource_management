class CreateQits < ActiveRecord::Migration
  def change
    create_table :qits do |t|
      t.string :borrower
      t.string :item
      t.integer :item_id
      t.datetime :borrowed_on
      t.datetime :returned_on
      t.string :item_status
      t.string :incharge

      t.timestamps null: false
    end
  end
end
