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

  # Validations

  # Callbacks

  # Delegates

  # Scopes

  # Methods

end
