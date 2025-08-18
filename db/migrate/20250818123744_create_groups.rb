class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :is_active, default: true, null: false
      t.references :organization, null: false, foreign_key: true
      
      t.timestamps
      
      t.index [:organization_id, :is_active]
    end
  end
end
