class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :weight, null: false
      t.string :category, null: false
      t.string :unit, null: false
      t.datetime :date, null: false

      t.timestamps
    end

    add_index :products, :category
  end
end
