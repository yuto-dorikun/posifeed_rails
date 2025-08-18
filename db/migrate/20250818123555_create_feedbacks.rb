class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.references :sender,   null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.references :feedback_category, null: false, foreign_key: true
      t.text    :message, null: false
      t.integer :points,  null: false
      t.timestamps
    end

    add_index :feedbacks, [:receiver_id, :created_at]
    add_index :feedbacks, [:sender_id, :created_at]

    add_check_constraint :feedbacks, 'sender_id != receiver_id', name: 'check_sender_not_receiver'
    add_check_constraint :feedbacks, 'length(message) >= 10 AND length(message) <= 500', name: 'check_message_length'
  end
end
