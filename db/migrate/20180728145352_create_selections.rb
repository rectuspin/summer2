class CreateSelections < ActiveRecord::Migration[5.2]
  def change
    create_table :selections do |t|
      t.text :content
      t.integer :question_id
      t.integer :num
      t.timestamps
    end
  end
end
