class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :organization_id, :bigint
    add_column :users, :department_id, :bigint
    add_column :users, :total_gratitude_points, :integer, default: 0
    add_column :users, :is_active, :boolean, default: true
    add_column :users, :role, :string, default: 'member', null: false

    add_index :users, :organization_id
    add_index :users, :department_id
    add_index :users, [:organization_id, :role]
  end
end
