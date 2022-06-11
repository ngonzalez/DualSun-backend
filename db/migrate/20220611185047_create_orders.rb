class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :company_name, null: false
      t.string :company_siren, null: false, unique: true
      t.string :order_address, null: false
      t.datetime :order_date, null: false
      t.jsonb :panels, null: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
