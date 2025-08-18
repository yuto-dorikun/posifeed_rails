class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string  :name,        null: false, limit: 200
      t.string  :invite_code, null: false, limit: 8
      t.boolean :is_active,   default: true
      t.timestamps
    end
    
    add_index :organizations, :invite_code, unique: true
  end
end
