class CreateQits < ActiveRecord::Migration
  def change
    create_table :qits do |t|
      t.string :borrower_id
      t.string :borrower
      t.string :item
      t.string :item_id
      t.date :borrowed_on
      t.date :returned_on
      t.string :item_status
      t.string :issue
      t.string :incharge

      t.timestamps null: false
    end
  end
end
