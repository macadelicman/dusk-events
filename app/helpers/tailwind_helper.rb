# app/helpers/tailwind_helper.rb
module TailwindHelper
  # Button styles
  def primary_button(text, url, options = {})
    css_class = "inline-flex items-center justify-center rounded-md bg-zinc-900 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-zinc-700 dark:bg-zinc-800 dark:hover:bg-zinc-700 #{options[:class]}"
    link_to text, url, class: css_class, data: options[:data], method: options[:method]
  end

  def secondary_button(text, url, options = {})
    css_class = "inline-flex items-center justify-center rounded-md border border-zinc-300 bg-white px-4 py-2 text-sm font-medium text-zinc-700 shadow-sm hover:bg-zinc-50 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-300 dark:hover:bg-zinc-700 #{options[:class]}"
    link_to text, url, class: css_class, data: options[:data], method: options[:method]
  end

  # Card container
  def card_container(options = {}, &block)
    content_tag :div, class: "rounded-lg bg-white p-6 shadow-sm ring-1 ring-zinc-950/5 dark:bg-zinc-800 dark:ring-white/10 #{options[:class]}" do
      capture(&block)
    end
  end

  # Back link with icon
  def back_link(text, url, options = {})
    link_to url, class: "inline-flex items-center gap-2 text-sm/6 text-zinc-500 dark:text-zinc-400 #{options[:class]}" do
      concat tag.svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 16 16", fill: "currentColor", class: "w-4 h-4 fill-zinc-400 dark:fill-zinc-500") do
        concat tag.path(fill_rule: "evenodd", d: "M9.78 4.22a.75.75 0 0 1 0 1.06L7.06 8l2.72 2.72a.75.75 0 1 1-1.06 1.06L5.47 8.53a.75.75 0 0 1 0-1.06l3.25-3.25a.75.75 0 0 1 1.06 0Z", clip_rule: "evenodd")
      end
      concat text
    end
  end

  # Heading tags
  def page_heading(text, options = {})
    content_tag :h1, text, class: "text-2xl font-bold tracking-tight text-zinc-950 dark:text-white #{options[:class]}"
  end

  def subheading(text, options = {})
    content_tag :h2, text, class: "text-base font-semibold leading-7 text-zinc-950 dark:text-white #{options[:class]}"
  end

  # Definition list formatter
  def detail_list(&block)
    content_tag :dl, class: "mt-4 space-y-4 divide-y divide-zinc-950/5 dark:divide-white/5" do
      capture(&block)
    end
  end

  def detail_item(term, description)
    content_tag :div, class: "flex justify-between pt-4 first:pt-0" do
      concat content_tag(:dt, term, class: "text-sm font-medium text-zinc-500 dark:text-zinc-400")
      concat content_tag(:dd, description, class: "text-sm text-zinc-950 dark:text-white")
    end
  end

  # Stats card
  def stats_card(title, value, change = nil, &block)
    card_container do
      concat content_tag(:div, title, class: "text-sm font-medium text-zinc-500 dark:text-zinc-400")
      concat content_tag(:div, class: "mt-2 flex items-baseline gap-2") do
        concat content_tag(:div, value, class: "text-4xl font-extrabold tracking-tight text-zinc-950 dark:text-white")
        concat display_change(change) if change.present?
      end
      if block_given?
        concat content_tag(:div, class: "mt-4") do
          capture(&block)
        end
      end
    end
  end

  # Table styles
  def tailwind_table(options = {}, &block)
    content_tag :div, class: "overflow-hidden rounded-xl border border-zinc-950/10 bg-white shadow-sm dark:border-white/10 dark:bg-zinc-800 #{options[:class]}" do
      content_tag :table, class: "w-full table-fixed divide-y divide-zinc-950/10 dark:divide-white/10" do
        capture(&block)
      end
    end
  end

  def table_header(&block)
    content_tag :thead do
      content_tag :tr do
        capture(&block)
      end
    end
  end

  def table_heading(text, options = {})
    align_class = options[:align] == :right ? "text-right" : "text-left"
    padding_class = if options[:first]
                      "py-3.5 pl-6 pr-3"
                    elsif options[:last]
                      "py-3.5 pl-3 pr-6"
                    else
                      "px-3 py-3.5"
                    end

    content_tag :th, text, scope: "col", class: "#{padding_class} #{align_class} text-sm font-semibold text-zinc-950 dark:text-white"
  end

  def table_body(&block)
    content_tag :tbody, class: "divide-y divide-zinc-950/5 dark:divide-white/5" do
      capture(&block)
    end
  end

  def table_row_link(url, options = {}, &block)
    link_to url, class: "group" do
      content_tag :tr, class: "group cursor-pointer hover:bg-zinc-50 dark:hover:bg-zinc-700/25" do
        capture(&block)
      end
    end
  end

  def table_cell(content, options = {})
    align_class = options[:align] == :right ? "text-right" : ""
    text_class = options[:muted] ? "text-zinc-500" : "text-zinc-950 dark:text-white"
    padding_class = if options[:first]
                      "py-4 pl-6 pr-3"
                    elsif options[:last]
                      "py-4 pl-3 pr-6"
                    else
                      "px-3 py-4"
                    end

    content_tag :td, content, class: "whitespace-nowrap #{padding_class} text-sm #{text_class} #{align_class}"
  end

  def empty_table_row(message, colspan)
    content_tag :tr do
      content_tag :td, message, colspan: colspan, class: "py-8 text-center text-sm text-zinc-500"
    end
  end

  # Image display with fallback - works with both single event and collection item
  def event_image(event, options = {})
    return "" if event.nil?

    if event.img_url.present?
      image_tag event.img_url, alt: event.name, class: "aspect-[3/2] rounded-lg shadow-sm object-cover #{options[:class]}"
    else
      content_tag :div, class: "aspect-[3/2] rounded-lg shadow-sm bg-zinc-100 dark:bg-zinc-800 flex items-center justify-center #{options[:class]}" do
        content_tag :span, event.name.first.upcase, class: "text-2xl font-bold text-zinc-400 dark:text-zinc-500"
      end
    end
  end

  # Event list item for index page
  def event_list_item(event, options = {}, &block)
    content_tag :li do
      concat content_tag(:div, "", class: "border-t border-zinc-200 dark:border-zinc-800") if options[:border]
      concat content_tag(:div, class: "flex items-center justify-between") do
        concat content_tag(:div, class: "flex gap-6 py-6") do
          concat content_tag(:div, class: "w-32 shrink-0") do
            concat link_to(event_path(event), aria_hidden: true) do
              event_image(event)
            end
          end

          concat content_tag(:div, class: "space-y-1.5") do
            concat content_tag(:div, class: "text-base/6 font-semibold") do
              concat link_to(event.name, event_path(event))
            end

            concat content_tag(:div, class: "text-xs/6 text-zinc-500") do
              concat "#{format_date(event.date)} at #{event.time} · #{event.location}"
            end

            concat content_tag(:div, class: "text-xs/6 text-zinc-600") do
              concat "#{event.tickets_sold}/#{event.tickets_available} tickets sold"
            end

            if block_given?
              concat capture(&block)
            end
          end
        end

        concat content_tag(:div, class: "flex items-center gap-4") do
          concat status_badge(event.status, class: "max-sm:hidden")

          concat content_tag(:div, class: "dropdown") do
            # Add dropdown menu here if needed
            concat link_to("#", class: "text-zinc-400 hover:text-zinc-600") do
              concat tag.svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 16 16", fill: "currentColor", class: "w-5 h-5") do
                concat tag.path(d: "M8 2a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3Zm0 4.5a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3Zm1.5 6a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0Z")
              end
            end
          end
        end
      end
    end
  end

  # Event Actions container - buttons for new, edit, etc.
  def event_actions(&block)
    content_tag :div, class: "flex flex-wrap items-end justify-between gap-4" do
      capture(&block)
    end
  end

  # Search and filter controls for index page
  def search_filter_container(&block)
    content_tag :div, class: "max-sm:w-full sm:flex-1" do
      capture(&block)
    end
  end

  # Search input with icon
  def search_input(name, placeholder, options = {})
    content_tag :div, class: "flex max-w-xl gap-4" do
      concat content_tag(:div, class: "flex-1") do
        content_tag :div, class: "relative" do
          concat tag.svg(xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 20 20", fill: "currentColor", class: "pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-zinc-400") do
            concat tag.path(fill_rule: "evenodd", d: "M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z", clip_rule: "evenodd")
          end
          concat text_field_tag(name, options[:value], class: "block w-full rounded-md border-0 py-1.5 pl-10 text-zinc-900 ring-1 ring-inset ring-zinc-300 placeholder:text-zinc-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6", placeholder: placeholder)
        end
      end

      if block_given?
        yield
      end
    end
  end
end

