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
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
