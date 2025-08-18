class AddDepartmentToUsers < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :users, :departments
  end
end
