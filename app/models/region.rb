# == Schema Information
#
# Table name: regions
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :uuid             not null
#
# Indexes
#
#  index_regions_on_country_id           (country_id)
#  index_regions_on_name_and_country_id  (name,country_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
class Region < ApplicationRecord
  belongs_to :country

  validates :name, presence: true, uniqueness: { scope: :country_id }
end
