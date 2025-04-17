# app/helpers/events_helper.rb
module EventsHelper
  # Display event availability info
  def event_availability(event)
    if event.sold_out?
      status_badge("Sold Out")
    else
      content_tag(:div) do
        concat content_tag(:span, "#{event.tickets_sold} / #{event.tickets_available} tickets sold", class: "me-2")
        concat progress_bar(event.tickets_sold, event.tickets_available, show_text: false, class: "mt-1")
      end
    end
  end

  # Display days until event with appropriate styling
  def days_until_event(event)
    return "Event has passed" unless event.upcoming?

    days = event.days_until_event

    if days.zero?
      content_tag(:span, "Today!", class: "text-danger fw-bold")
    elsif days == 1
      content_tag(:span, "Tomorrow!", class: "text-warning fw-bold")
    elsif days <= 7
      content_tag(:span, "#{days} days away", class: "text-warning")
    else
      "#{days} days away"
    end
  end

  # Format ticket price
  def ticket_price(event)
    return "Free" if event.ticket_price.zero?
    format_currency(event.ticket_price)
  end

  # Display a change value with arrow and color
  def display_change(value, options = {})
    return "N/A" if value.blank?

    direction = value >= 0 ? "up" : "down"
    color_class = value >= 0 ? "text-success" : "text-danger"

    content_tag(:span, class: "#{color_class} #{options[:class]}") do
      if direction == "up"
        concat tag.svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 20 20", fill: "currentColor", class: "inline-block w-5 h-5 text-emerald-500 dark:text-emerald-400") do
          concat tag.path(fill_rule: "evenodd", d: "M10 17a.75.75 0 01-.75-.75V5.612L5.29 9.77a.75.75 0 01-1.08-1.04l5.25-5.5a.75.75 0 011.08 0l5.25 5.5a.75.75 0 11-1.08 1.04l-3.96-4.158V16.25A.75.75 0 0110 17z", clip_rule: "evenodd")
        end
      else
        concat tag.svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 20 20", fill: "currentColor", class: "inline-block w-5 h-5 text-red-500 dark:text-red-400") do
          concat tag.path(fill_rule: "evenodd", d: "M10 3a.75.75 0 01.75.75v10.638l3.96-4.158a.75.75 0 111.08 1.04l-5.25 5.5a.75.75 0 01-1.08 0l-5.25-5.5a.75.75 0 111.08-1.04l3.96 4.158V3.75A.75.75 0 0110 3z", clip_rule: "evenodd")
        end
      end
      concat " #{format_percentage(value.abs)}"
    end
  end

  # Status badge with Tailwind
  def status_badge(status, options = {})
    status_class = case status&.downcase
                   when "on sale" then "bg-lime-50 text-lime-700 ring-lime-600/10 dark:bg-lime-500/10 dark:text-lime-400 dark:ring-lime-500/20"
                   when "closed" then "bg-zinc-50 text-zinc-700 ring-zinc-600/10 dark:bg-zinc-500/10 dark:text-zinc-400 dark:ring-zinc-500/20"
                   when "sold out" then "bg-red-50 text-red-700 ring-red-600/10 dark:bg-red-500/10 dark:text-red-400 dark:ring-red-500/20"
                   when "cancelled" then "bg-red-50 text-red-700 ring-red-600/10 dark:bg-red-500/10 dark:text-red-400 dark:ring-red-500/20"
                   when "postponed" then "bg-yellow-50 text-yellow-700 ring-yellow-600/10 dark:bg-yellow-500/10 dark:text-yellow-400 dark:ring-yellow-500/20"
                   else "bg-blue-50 text-blue-700 ring-blue-600/10 dark:bg-blue-500/10 dark:text-blue-400 dark:ring-blue-500/20"
                   end

    content_tag(:span, status, class: "inline-flex items-center rounded-full px-2 py-1 text-xs font-medium ring-1 ring-inset #{status_class} #{options[:class]}")
  end

  # Progress bar with Tailwind
  def progress_bar(value, max, options = {})
    percentage = max.zero? ? 0 : ((value.to_f / max) * 100).round

    color_class = if percentage >= 90
                    "bg-red-500 dark:bg-red-400"
                  elsif percentage >= 70
                    "bg-yellow-500 dark:bg-yellow-400"
                  elsif percentage >= 50
                    "bg-blue-500 dark:bg-blue-400"
                  else
                    "bg-emerald-500 dark:bg-emerald-400"
                  end

    content_tag(:div, class: "overflow-hidden rounded-full bg-zinc-100 dark:bg-zinc-700 #{options[:class]}") do
      content_tag(:div,
                  options[:show_text] ? "#{percentage}%" : "",
                  class: "h-full #{color_class} text-center text-xs font-medium text-white",
                  style: "width: #{percentage}%")
    end
  end
end
