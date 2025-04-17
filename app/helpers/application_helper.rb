# app/helpers/application_helper.rb
module ApplicationHelper
  # Format any currency value
  def format_currency(amount)
    return "N/A" if amount.blank?
    number_to_currency(amount, precision: 2)
  end

  # Format a percentage with appropriate sign
  def format_percentage(percentage, include_sign: true)
    return "N/A" if percentage.blank?

    sign = ""
    if include_sign && percentage > 0
      sign = "+"
    end

    "#{sign}#{number_to_percentage(percentage, precision: 2)}"
  end

  # Render a status badge with appropriate color
  def status_badge(status, options = {})
    status_class = case status&.downcase
                   when "on sale" then "bg-success"
                   when "closed" then "bg-secondary"
                   when "sold out" then "bg-danger"
                   when "cancelled" then "bg-danger"
                   when "postponed" then "bg-warning"
                   else "bg-info"
                   end

    content_tag(:span, status, class: "badge #{status_class} #{options[:class]}")
  end

  # Format a date with fallback
  def format_date(date, format = :long)
    return "N/A" if date.blank?
    date.strftime(date_format_for(format))
  end

  # Date format helper
  def date_format_for(format_name)
    case format_name
    when :short then "%b %d, %Y"
    when :long then "%B %d, %Y"
    when :with_time then "%B %d, %Y at %I:%M %p"
    when :month_year then "%B %Y"
    else "%b %d, %Y"
    end
  end

  # Create a progress bar
  def progress_bar(value, max, options = {})
    percentage = max.zero? ? 0 : ((value.to_f / max) * 100).round

    color_class = options[:color_class] || "bg-primary"

    # Change color based on percentage if not specified
    if options[:color_class].blank?
      color_class = if percentage >= 90
                      "bg-danger"
                    elsif percentage >= 70
                      "bg-warning"
                    elsif percentage >= 50
                      "bg-info"
                    else
                      "bg-primary"
                    end
    end

    content_tag(:div, class: "progress #{options[:class]}") do
      content_tag(:div,
                  options[:show_text] ? "#{percentage}%" : "",
                  class: "progress-bar #{color_class}",
                  role: "progressbar",
                  style: "width: #{percentage}%",
                  "aria-valuenow" => value,
                  "aria-valuemin" => 0,
                  "aria-valuemax" => max)
    end
  end

  # Flash messages helper
  def render_flash_messages
    flash.each do |type, message|
      flash_class = case type
                    when "notice" then "alert-success"
                    when "alert" then "alert-danger"
                    else "alert-#{type}"
                    end

      concat(content_tag(:div, message, class: "alert #{flash_class} alert-dismissible fade show", role: "alert") do
        concat message
        concat content_tag(:button, type: "button", class: "btn-close", data: { bs_dismiss: "alert" }, "aria-label" => "Close")
      end)
    end
    nil
  end
end
