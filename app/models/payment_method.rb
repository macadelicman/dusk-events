# == Schema Information
#
# Table name: payment_methods
#
#  id          :uuid             not null, primary key
#  card_number :string
#  card_type   :string
#  expiry      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :uuid             not null
#
# Indexes
#
#  index_payment_methods_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
class PaymentMethod < ApplicationRecord
  belongs_to :customer
end
