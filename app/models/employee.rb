# == Schema Information
#
# Table name: employees
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Employee < ApplicationRecord
  # Relations
  has_one :employee_authenticate
  has_one :employee_profile
  has_many :blogs
  has_many :left_employees

  # Validations

  # Callbacks

  # Delegates

  # Scopes

  # Methods

  def active?
    self.employee_authenticate && self.employee_profile
  end

  def already_left?
    self.left_employees.precent?
  end

  def leave!
    LeftEmployee.create(employee: self, email: self.employee_authenticate.email, name: self.employee_profile.name)
    self.employee_profile.destroy
    self.employee_authenticate.destroy
  end
end
