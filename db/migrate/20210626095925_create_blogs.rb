class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.references :employee, foreign_key: true, index: true
      t.string :title, null: false, default: ""

      t.timestamps
    end
  end
end
