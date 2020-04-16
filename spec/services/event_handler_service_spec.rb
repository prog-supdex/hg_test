require 'rails_helper'

describe EventHandlerService do
  let(:event) { FactoryBot.create(:event, name: 'Создание папки', event_type: :creator_folder, param1: 'test') }
  let(:event_two) { FactoryBot.create(:event, name: 'Переименовать папку', event_type: :rename_folder, param1: 'test', param2: 'test2') }

  describe '#call' do
    it 'calls service by Event' do
      expect(Events::CreatorFolderService).to receive(:new).with(event.param1, event.param2)
      described_class.call(event: event)

      event.reload

      expect(event.executed_at).to_not be nil
    end

    it 'saves error to Event' do
      allow(Dir).to receive(:exist?).and_return(false)

      described_class.call(event: event_two)

      expect(event_two.error_message).to_not be nil
    end
  end
end
