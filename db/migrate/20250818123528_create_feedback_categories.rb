class CreateFeedbackCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_categories do |t|
      t.string  :name,          null: false, limit: 100
      t.string  :emoji,         null: false, limit: 10
      t.integer :points_value,  null: false
      t.string  :color,         null: false, limit: 7
      t.integer :sort_order,    default: 0
      t.boolean :is_active,     default: true
      t.boolean :is_system_default, default: false, null: false
      t.references :organization, null: true, foreign_key: true
      t.timestamps
    end

    add_index :feedback_categories, [:name, :organization_id], unique: true
    add_index :feedback_categories, [:organization_id, :is_system_default]
  end
end
