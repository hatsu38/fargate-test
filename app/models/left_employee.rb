# == Schema Information
#
# Table name: left_employees
#
#  id                   :bigint           not null, primary key
#  employee_id          :bigint
#  email(emailアドレス) :string(255)      default(""), not null
#  name(従業員名)       :string(255)      default(""), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_left_employees_on_employee_id  (employee_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#
class LeftEmployee < ApplicationRecord

  # Relations
  belongs_to :employee

  # Validations

  # Callbacks

  # Delegates

  # Scopes

  # Methods
end
