# == Schema Information
#
# Table name: employee_authenticates
#
#  id                     :bigint           not null, primary key
#  employee_id            :bigint
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_employee_authenticates_on_confirmation_token    (confirmation_token) UNIQUE
#  index_employee_authenticates_on_email                 (email) UNIQUE
#  index_employee_authenticates_on_employee_id           (employee_id) UNIQUE
#  index_employee_authenticates_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#
class EmployeeAuthenticate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  # Relations
  belongs_to :employee

  # Validations

  # Callbacks
  before_validation :set_employee

  # Delegates

  # Scopes

  # Methods

  private

  def set_employee
    self.employee = Employee.new if employee.nil?
  end
end
