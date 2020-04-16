class EventsController < ApplicationController
  def index
    @events = Event.where(executed_at: nil)
  end

  def create
    @event = Event.new(permitted_params)

    if @event.save
      EventsJob.set(wait: rand(5..15).seconds).perform_later(@event)

      redirect_to events_path
    else
      render :new
    end
  end

  def new
    @event = Event.new
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path
  end

  private

  def permitted_params
    params.require(:event).permit(:name, :event_type, :param1, :param2)
  end
end
