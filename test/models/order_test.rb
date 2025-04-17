# == Schema Information
#
# Table name: orders
#
#  id                :uuid             not null, primary key
#  amount_cad        :decimal(10, 2)
#  amount_usd        :decimal(10, 2)
#  fee               :decimal(10, 2)
#  net_amount        :decimal(10, 2)
#  order_date        :date
#  url               :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  customer_id       :uuid             not null
#  event_id          :uuid             not null
#  payment_method_id :uuid             not null
#  transaction_id    :string
#
# Indexes
#
#  index_orders_on_customer_id        (customer_id)
#  index_orders_on_event_id           (event_id)
#  index_orders_on_order_date         (order_date)
#  index_orders_on_payment_method_id  (payment_method_id)
#  index_orders_on_transaction_id     (transaction_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (payment_method_id => payment_methods.id)
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
