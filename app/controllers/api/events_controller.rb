# app/controllers/api/events_controller.rb
module Api
  class EventsController < ApplicationController
    # Uncomment authentication if needed
    # before_action :authenticate_user!
    before_action :set_event, only: [:show, :update, :destroy]

    # GET /api/events
    def index
      # Ordering by date (and by time if appropriate)
      @events = Event.all.order(date: :asc, time: :asc)
      render json: @events
    end

    # GET /api/events/:id
    def show
      render json: @event
    end

    # POST /api/events
    def create
      @event = Event.new(event_params)
      # Removed owner assignment as the new model does not include an owner field

      if @event.save
        render json: @event, status: :created, location: api_event_url(@event)
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

    # PUT/PATCH /api/events/:id
    def update
      if @event.update(event_params)
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/events/:id
    def destroy
      @event.destroy!
      head :no_content
    end

    private

    def set_event
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Event not found" }, status: :not_found
    end

    def event_params
      params.require(:event).permit(
        :name, :url, :date, :time, :location,
        :total_revenue, :total_revenue_change,
        :tickets_available, :tickets_sold, :tickets_sold_change,
        :page_views, :page_views_change, :status,
        :img_url, :thumb_url
      )
    end
  end
end
