class EventsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    EventHandlerService.call(event: args[0])
  end
end
