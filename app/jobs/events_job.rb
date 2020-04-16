class EventsJob < ApplicationJob
  queue_as :default

  def perform(event)
    EventHandlerService.call(event: event)
  end
end
