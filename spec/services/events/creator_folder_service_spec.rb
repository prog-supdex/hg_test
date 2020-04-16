require 'rails_helper'
require 'fakefs/spec_helpers'

describe Events::CreatorFolderService do
  include FakeFS::SpecHelpers

  let(:directory) { 'testing_directory' }

  it 'creates folder' do
    FakeFS.activate!
    FakeFS::FileSystem.clone(Rails.root.join('public/events').to_s)

    path = described_class.new(directory).call

    expect(Dir.exist?(path)).to be true

    FakeFS.deactivate!
  end
end
