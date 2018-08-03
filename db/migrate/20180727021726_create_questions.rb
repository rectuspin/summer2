class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :post_id
      t.text :q_type
      t.timestamps
    end
  end
end
