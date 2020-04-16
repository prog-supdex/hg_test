require 'rails_helper'
ActiveJob::Base.queue_adapter = :test

RSpec.describe EventsJob, type: :job do
  include ActiveJob::TestHelper

  let(:event) { FactoryBot.create(:event, name: 'Создание папки', event_type: :creator_folder, param1: 'test') }
  let(:job) { described_class.perform_later(event) }

  it 'executes perform' do
    described_class.perform_later(event)
    expect(described_class).to have_been_enqueued.with(event)
  end

  it 'calls EventHandlerService' do
    expect(EventHandlerService).to receive(:call).with(event: event)
    described_class.perform_later(event)

    perform_enqueued_jobs { job }
  end
end
