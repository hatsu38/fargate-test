class CreateLeftEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :left_employees, comment: "退会した従業員" do |t|
      t.references :employee, foreign_key: true, index: true
      t.string :email, null: false, default: "", comment: "emailアドレス"
      t.string :name, null: false, default: "", comment: "従業員名"

      t.timestamps
    end
  end
end
