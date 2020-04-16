class Event < ApplicationRecord
  enum event_type: {
    creator_folder: 'creator_folder',
    uploader_file: 'uploader_file',
    unzipper: 'unzipper',
    zipper: 'zipper',
    tree_to_file: 'tree_to_file',
    rename_folder: 'rename_folder',
    converter_html_to_pdf: 'converter_html_to_pdf',
    delete_folder: 'delete_folder'
  }

  validates :name, :event_type, :param1, presence: true
end
