class AddUseridToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :user_id, :integer
  end
end
