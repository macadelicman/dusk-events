# == Schema Information
#
# Table name: events
#
#  id                   :uuid             not null, primary key
#  date                 :date
#  img_url              :string
#  location             :string
#  name                 :string           not null
#  page_views           :integer
#  page_views_change    :decimal(5, 2)
#  status               :string
#  thumb_url            :string
#  tickets_available    :integer
#  tickets_sold         :integer
#  tickets_sold_change  :decimal(5, 2)
#  time                 :string
#  total_revenue        :decimal(10, 2)
#  total_revenue_change :decimal(5, 2)
#  url                  :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_events_on_date        (date)
#  index_events_on_img_url     (img_url)
#  index_events_on_location    (location)
#  index_events_on_name        (name)
#  index_events_on_page_views  (page_views)
#  index_events_on_status      (status)
#  index_events_on_thumb_url   (thumb_url)
#
class Event < ApplicationRecord
  # Associations
  has_many :orders, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true
  validates :tickets_available, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :tickets_sold, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Scopes for common queries
  scope :on_sale, -> { where(status: "On Sale") }
  scope :closed, -> { where(status: "Closed") }
  scope :upcoming, -> { where("date >= ?", Date.today) }
  scope :past, -> { where("date < ?", Date.today) }
  scope :popular, -> { order(tickets_sold: :desc) }
  scope :recent, -> { order(date: :desc) }

  # Constants
  EVENT_STATUSES = ["On Sale", "Closed", "Cancelled", "Postponed"].freeze
  DEFAULT_CAPACITY = 500 # Default capacity if not specified

  # Calculate tickets sold - either from database or from orders count
  def tickets_sold
    # Return the stored value if present
    return self[:tickets_sold] if self[:tickets_sold].present?

    # Otherwise calculate from orders (each order represents one ticket)
    orders.count
  end

  # Calculate tickets available - either from database or a default value
  def tickets_available
    # Return the stored value if present
    return self[:tickets_available] if self[:tickets_available].present?

    # Otherwise use the default capacity
    DEFAULT_CAPACITY
  end

  # Determine if the event is sold out
  def sold_out?
    tickets_sold >= tickets_available
  end

  # Calculate percentage of available tickets
  def availability_percentage
    return 0 if tickets_available.zero?
    ((tickets_available - tickets_sold).to_f / tickets_available * 100).round(2)
  end

  # Return event date in a formatted string
  def formatted_date
    date&.strftime("%B %d, %Y")
  end

  # Human-readable status text based on availability
  def availability_status
    if sold_out?
      "Sold Out"
    elsif status == "Closed"
      "Closed"
    else
      "#{tickets_available - tickets_sold} tickets available"
    end
  end

  # Calculate days until the event
  def days_until_event
    return nil unless date.present?
    (date - Date.today).to_i
  end

  # Check if event is in the future
  def upcoming?
    date.present? && date >= Date.today
  end

  # Calculate average revenue per ticket
  def revenue_per_ticket
    return 0 if tickets_sold.zero?
    total_revenue.to_f / tickets_sold
  end

  # Calculate total revenue from all associated orders
  def calculate_revenue_from_orders
    orders.sum(:amount)
  end

  # Update event statistics - called whenever an order is created/updated/destroyed

  def update_statistics!
    # Store original values to calculate changes
    original_tickets_sold = self[:tickets_sold] || 0
    original_total_revenue = self[:total_revenue] || 0

    # Update tickets sold count
    self.tickets_sold = orders.count

    # Update total revenue from all orders
    self.total_revenue = calculate_revenue_from_orders

    # Calculate percentage change in tickets sold
    if original_tickets_sold > 0
      self.tickets_sold_change = ((self.tickets_sold - original_tickets_sold).to_f / original_tickets_sold * 100).round(2)
    end

    # Calculate percentage change in total revenue
    if original_total_revenue > 0
      self.total_revenue_change = ((self.total_revenue - original_total_revenue).to_f / original_total_revenue * 100).round(2)
    end

    # Update event status if it's sold out
    if self.sold_out? && self.status == "On Sale"
      self.status = "Closed"
    end

    # Save all changes to the database
    save
  end

  # Get the average ticket price based on orders
  def ticket_price
    return 0 if orders.empty?
    orders.average(:amount).to_f.round(2)
  end

  # Format revenue as currency string
  def formatted_revenue
    total_revenue.present? ? "$#{'%.2f' % total_revenue}" : "N/A"
  end

  # Get remaining ticket count
  def remaining_tickets
    tickets_available - tickets_sold
  end

  # Check if the event is almost sold out (less than 10% of tickets remaining)
  def almost_sold_out?
    remaining_tickets.to_f / tickets_available < 0.1 && !sold_out?
  end
end
