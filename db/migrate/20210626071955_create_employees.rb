class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees, comment: "従業員" do |t|
      t.references :employee_authenticate,foreign_key: true, index: { unique: true }
      t.string :name, null: false, comment: "名前"

      t.timestamps
    end
  end
end
