class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name,      null: false
      t.text :info,             null: false
      t.integer :category_id,   null: false
      t.integer :condition,     null: false
      t.integer :delivery_id,   null: false
      t.integer :prefecture_id, null: false
      t.integer :send_day_id,   null: false
      t.integer :price,         null: false
      t.references :user,       null: false, foreign_key: true
      t.timestamps
    end
  end
end
