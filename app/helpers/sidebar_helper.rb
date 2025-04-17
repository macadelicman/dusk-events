module SidebarHelper
  def sidebar(options = {}, &block)
    css_class = "flex h-full min-h-0 flex-col #{options[:class]}"
    content_tag(:nav, capture(&block), class: css_class,
                data: { controller: "sidebar" })
  end

  def sidebar_header(options = {}, &block)
    css_class = "flex flex-col border-b border-zinc-950/5 p-4 dark:border-white/5 [&>[data-slot=section]+[data-slot=section]]:mt-2.5 #{options[:class]}"
    content_tag(:div, capture(&block), class: css_class)
  end

  def sidebar_body(options = {}, &block)
    css_class = "flex flex-1 flex-col overflow-y-auto p-4 [&>[data-slot=section]+[data-slot=section]]:mt-8 #{options[:class]}"
    content_tag(:div, capture(&block), class: css_class)
  end

  def sidebar_footer(options = {}, &block)
    css_class = "flex flex-col border-t border-zinc-950/5 p-4 dark:border-white/5 [&>[data-slot=section]+[data-slot=section]]:mt-2.5 #{options[:class]}"
    content_tag(:div, capture(&block), class: css_class)
  end

  def sidebar_section(options = {}, &block)
    css_class = "flex flex-col gap-0.5 #{options[:class]}"
    content_tag(:div, capture(&block), "data-slot" => "section", class: css_class)
  end

  def sidebar_divider(options = {})
    css_class = "my-4 border-t border-zinc-950/5 lg:-mx-4 dark:border-white/5 #{options[:class]}"
    content_tag(:hr, nil, class: css_class)
  end

  def sidebar_spacer(options = {})
    css_class = "mt-8 flex-1 #{options[:class]}"
    content_tag(:div, nil, "aria-hidden" => "true", class: css_class)
  end

  def sidebar_heading(options = {}, &block)
    css_class = "mb-1 px-2 text-xs/6 font-medium text-zinc-500 dark:text-zinc-400 #{options[:class]}"
    content_tag(:h3, capture(&block), class: css_class)
  end

  def sidebar_item(options = {}, &block)
    current = options.delete(:current) || false
    href = options.delete(:href)

    base_class = "flex w-full items-center gap-3 rounded-lg px-2 py-2.5 text-left text-base/6 font-medium text-zinc-950 sm:py-2 sm:text-sm/5"
    icon_class = "*:data-[slot=icon]:size-6 *:data-[slot=icon]:shrink-0 *:data-[slot=icon]:fill-zinc-500 sm:*:data-[slot=icon]:size-5"
    trailing_icon_class = "*:last:data-[slot=icon]:ml-auto *:last:data-[slot=icon]:size-5 sm:*:last:data-[slot=icon]:size-4"
    avatar_class = "*:data-[slot=avatar]:-m-0.5 *:data-[slot=avatar]:size-7 sm:*:data-[slot=avatar]:size-6"
    hover_class = "hover:bg-zinc-950/5 hover:*:data-[slot=icon]:fill-zinc-950"
    active_class = "active:bg-zinc-950/5 active:*:data-[slot=icon]:fill-zinc-950"
    current_class = current ? "*:data-[slot=icon]:fill-zinc-950" : ""
    dark_mode_class = "dark:text-white dark:*:data-[slot=icon]:fill-zinc-400 dark:hover:bg-white/5 dark:hover:*:data-[slot=icon]:fill-white dark:active:bg-white/5 dark:active:*:data-[slot=icon]:fill-white"
    dark_current_class = current ? "dark:*:data-[slot=icon]:fill-white" : ""

    css_class = "#{base_class} #{icon_class} #{trailing_icon_class} #{avatar_class} #{hover_class} #{active_class} #{current_class} #{dark_mode_class} #{dark_current_class} #{options[:class]}"

    item_content = touch_target(capture(&block))

    wrapper_content = if href
                        link_to(item_content, href, class: css_class,
                                "data-current" => current ? "true" : nil,
                                "data-sidebar-target" => "item")
                      else
                        content_tag(:button, item_content, class: "cursor-default #{css_class}",
                                    "data-current" => current ? "true" : nil,
                                    "data-sidebar-target" => "item")
                      end

    content_tag(:span, class: "relative #{options[:class]}") do
      wrapper_content
    end
  end

  def sidebar_label(options = {}, &block)
    css_class = "truncate #{options[:class]}"
    content_tag(:span, capture(&block), class: css_class)
  end

  def sidebar_current_indicator
    content_tag(:span, "", class: "current-indicator hidden md:block",
                "data-sidebar-target" => "currentIndicator")
  end

  def touch_target(content)
    content_tag(:span, content, class: "relative block w-full")
  end
end
