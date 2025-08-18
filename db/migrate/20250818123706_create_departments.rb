class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments do |t|
      t.string :name, null: false
      t.text :description
      t.integer :level, null: false
      t.references :parent_department, null: true, foreign_key: { to_table: :departments }
      t.references :organization, null: false, foreign_key: true
      t.integer :position, default: 0
      
      t.timestamps
    end
    
    add_index :departments, [:organization_id, :level]
  end
end
