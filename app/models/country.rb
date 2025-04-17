# == Schema Information
#
# Table name: countries
#
#  id         :uuid             not null, primary key
#  code       :string
#  flag_url   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_countries_on_code  (code) UNIQUE
#  index_countries_on_name  (name)
#
class Country < ApplicationRecord
  has_many :regions, dependent: :destroy
  has_many :customers, dependent: :restrict_with_error

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
