require 'rails_helper'

describe Events::ParseSupCom2ReplayService do
  let(:path_to_replay) { Rails.root.join('spec/fixtures/replays/battle.SC2ReplayDLC').to_s }
  let(:directory) { 'replays' }

  it 'creates file with content' do
    buffer = StringIO.new

    allow(Dir).to receive(:exist?).with(Rails.root.join('public/events', directory).to_s).and_return(true)
    allow(File).to receive(:open).with(Rails.root.join('public/events', directory, 'battle.txt').to_s, 'w+').and_yield(buffer)

    described_class.new(path_to_replay, directory).call

    expect(buffer.string).to eq(SupCom2ReplayParser.call(path_to_replay).to_s)
  end
end
