module EventHandlerService
  def self.call(event:)
    raise Exception, 'Argument event is not instance of Event' if event.blank? || !event.is_a?(Event)

    data = { executed_at: Time.now }

    begin
      Events.const_get("#{event.event_type}_service".classify).new(event.param1, event.param2).call
    rescue Exception => error
      data[:error_message] = error.message
    end

    event.update_attributes(data)
  end
end
