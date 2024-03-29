class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.integer :order_id, null: false, unique: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.datetime :deleted_at
      t.index [:order_id], name: :index_customers_on_order_id, unique: true
      t.timestamps
    end
  end
end
