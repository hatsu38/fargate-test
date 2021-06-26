# == Schema Information
#
# Table name: employees
#
#  id                         :bigint           not null, primary key
#  employee_authenticate_id   :bigint
#  name(名前)                 :string(255)      not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_employees_on_employee_authenticate_id  (employee_authenticate_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (employee_authenticate_id => employee_authenticates.id)
#
class Employee < ApplicationRecord
  # Relations
  belongs_to :employee_authenticate

  # Validations
  validates :name, presence: true

  # Callbacks

  # Delegates

  # Scopes

  # Methods

end
