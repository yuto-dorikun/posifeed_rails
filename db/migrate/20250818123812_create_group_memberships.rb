class CreateGroupMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :group_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :role, null: false, default: 'member'
      
      t.timestamps
      
      t.index [:user_id, :group_id], unique: true
      t.index [:group_id, :role]
    end
  end
end
