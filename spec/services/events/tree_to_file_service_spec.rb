require 'rails_helper'

describe Events::TreeToFileService do
  let(:directory) { Dir.pwd }
  let(:file_name) { 'test.txt' }

  it 'creates file with content' do
    buffer = StringIO.new

    allow(File).to receive(:open).with(Rails.root.join('public/events', file_name).to_s, 'w+').and_yield(buffer)

    described_class.new(directory, file_name).call

    expect(buffer.string).to eq(TTY::Tree.new(directory).render)
  end
end
