class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

      t.timestamps
      t.string :sku, null: false
      t.text :description
    end
  end
end
