class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.text :content
      t.integer :post_id
      t.integer :answer_id
      t.text :item_email

      t.timestamps
    end
  end
end
