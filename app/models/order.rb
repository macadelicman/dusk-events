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
class Order < ApplicationRecord
  # Associations
  belongs_to :payment_method
  belongs_to :customer
  belongs_to :event

  # Validations
  validates :transaction_id, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :fee, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :order_date, presence: true

  # Scopes for common queries
  scope :recent, -> { order(order_date: :desc).limit(10) }
  scope :for_event, ->(event_id) { where(event_id: event_id) }
  scope :today, -> { where(order_date: Date.today) }
  scope :this_month, -> { where(order_date: Date.today.beginning_of_month..Date.today.end_of_month) }
  scope :successful, -> { where.not(transaction_id: nil) }

  # Callbacks
  before_validation :set_order_date, on: :create
  before_save :calculate_net_amount, if: -> { amount_changed? || fee_changed? }

  # Callbacks to update event statistics when an order is created, updated, or destroyed
  after_create :update_event_statistics
  after_update :update_event_statistics, if: -> { saved_change_to_amount? || saved_change_to_event_id? }
  after_destroy :update_event_statistics

  # Set the order date to today if not specified
  def set_order_date
    self.order_date ||= Date.today
  end

  # Calculate net amount (amount minus fee)
  def calculate_net_amount
    self.net_amount = amount - (fee || 0)
  end

  # Trigger event statistics update
  def update_event_statistics
    # Update statistics for the current event
    event.update_statistics! if event.present?

    # If the event was changed, update stats for the previous event too
    if saved_change_to_event_id? && event_id_previously_was.present?
      previous_event = Event.find_by(id: event_id_previously_was)
      previous_event&.update_statistics!
    end
  end

  # Format amount as currency string
  def formatted_amount
    amount.present? ? "$#{'%.2f' % amount}" : "N/A"
  end

  # Format transaction ID for display
  def formatted_transaction_id
    "TX-#{transaction_id.last(8).upcase}" if transaction_id.present?
  end

  # Format order date for display
  def formatted_date
    order_date&.strftime('%b %d, %Y')
  end

  # Check if order is still refundable (within 30 days)
  def refundable?
    order_date.present? && (Date.today - order_date) <= 30
  end

  # Format fee as currency string
  def formatted_fee
    fee.present? ? "$#{'%.2f' % fee}" : "$0.00"
  end

  # Format net amount as currency string
  def formatted_net_amount
    net_amount.present? ? "$#{'%.2f' % net_amount}" : "N/A"
  end

  # Calculate fee percentage
  def fee_percentage
    return 0 if amount.blank? || amount.zero? || fee.blank?
    ((fee / amount) * 100).round(2)
  end

  # Complete the order process
  def complete!
    # Additional logic for completing an order could go here
    # For example, sending email confirmations, updating inventory, etc.
    update(completed_at: Time.current)
  end

  # Get customer name with fallback
  def customer_name
    customer&.name || "Guest"
  end

  # Get event name with fallback
  def event_name
    event&.name || "Unknown Event"
  end
end
