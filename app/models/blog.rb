# == Schema Information
#
# Table name: blogs
#
#  id              :bigint           not null, primary key
#  employee_id     :bigint
#  title(タイトル) :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_blogs_on_employee_id  (employee_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#
class Blog < ApplicationRecord
  # Relations
  belongs_to :employee

  # Validations
  validates :title, presence: true

  # Callbacks

  # Delegates

  # Scopes

  # Methods
end
