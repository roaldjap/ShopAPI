# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

sales_report = File.read(Rails.root.join("lib", "seeds", "sales_report.csv"))
csv = CSV.parse(sales_report, :headers => true, :encoding => "ISO-8859-1")

csv.each do |row|
  Transaction.create({
    apn_code: row["APN code"],
    rrp: row["R.R.P."],
    last_buy_price: row["Last Buy Price"],
    item_desc: row["Item description"],
    author: row["Author"],
    product_category: row["Product Category"],
    actual_stock: row["Actual Stock On Hand"],
    trans_date: row["Trans Date"],
    trans_time: row["Trans Time"],
    trans_document: row["Trans Document Number"],
    trans_ref: row["Trans Reference Number"],
    trans_qty: row["Trans Quantity"],
    trans_total_ex_tax: row["Trans Total extax value"],
    trans_total_tax: row["Trans Total tax"],
    trans_discount: row["Trans Total discount given"],
  })

  puts "#{row["APN code"]} saved!"
end

puts "There are now #{Transaction.count} rows in the transactions table"
