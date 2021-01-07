class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :apn_code, :limit => 8
      t.decimal :rrp
      t.decimal :last_buy_price
      t.string :item_desc
      t.string :author
      t.string :product_category
      t.integer :actual_stock
      t.date :trans_date
      t.time :trans_time
      t.string :trans_document
      t.string :trans_ref
      t.integer :trans_qty
      t.decimal :trans_total_ex_tax
      t.decimal :trans_total_tax
      t.decimal :trans_discount

      t.timestamps
    end
  end
end
