# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  title      :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Blog < ApplicationRecord
end
