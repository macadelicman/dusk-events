# app/helpers/orders_helper.rb
module OrdersHelper
  # Format transaction ID
  def format_transaction_id(transaction_id)
    return "N/A" if transaction_id.blank?
    "TX-#{transaction_id.last(8).upcase}"
  end

  # Calculate and display fee percentage
  def fee_percentage(order)
    return "N/A" if order.amount.blank? || order.amount.zero? || order.fee.blank?

    percentage = ((order.fee / order.amount) * 100).round(2)
    number_to_percentage(percentage, precision: 2)
  end

  # Display refund eligibility
  def refund_eligibility(order)
    if order.refundable?
      content_tag(:span, "Eligible for refund", class: "text-success")
    else
      content_tag(:span, "Non-refundable", class: "text-secondary")
    end
  end

  # Display payment method info
  def payment_method_info(payment_method)
    return "N/A" if payment_method.nil?

    icon_class = case payment_method.card_type&.downcase
                 when "visa" then "bi bi-credit-card"
                 when "mastercard" then "bi bi-credit-card"
                 when "american express" then "bi bi-credit-card"
                 else "bi bi-credit-card"
                 end

    card_number = payment_method.card_number.present? ? "•••• #{payment_method.card_number}" : "N/A"

    content_tag(:div, class: "payment-method-info") do
      concat content_tag(:i, nil, class: icon_class)
      concat " #{payment_method.card_type} #{card_number}"
      if payment_method.expiry.present?
        concat content_tag(:small, " (Expires: #{payment_method.expiry})", class: "text-muted")
      end
    end
  end

  # Order receipt download link
  def order_receipt_link(order)
    link_to "Download Receipt", "#", class: "btn btn-sm btn-outline-secondary"
    # In a real application, this would point to a receipt PDF generation action
  end

  # Order payment status
  def payment_status(order)
    if order.transaction_id.present?
      status_badge("Paid", class: "bg-success")
    else
      status_badge("Pending", class: "bg-warning")
    end
  end
end
