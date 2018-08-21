class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :post_id
      t.text :q_type
      t.integer :view_type, default: 0
      t.timestamps
    end
  end
end
