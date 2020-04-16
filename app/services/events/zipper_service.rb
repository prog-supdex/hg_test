require 'zip'

module Events
  class ZipperService
    include Events

    attr_reader :url_file_to_zip, :target_folder_path

    def initialize(*args)
      @url_file_to_zip = args[0]
      @target_folder_path = args[1]
    end

    def call
      loaded_file_path =
        if url_file_to_zip.start_with?('http', 'https')
          UploaderFileService.new(url_file_to_zip).call
        elsif File.exist?(url_file_to_zip)
          url_file_to_zip
        end

      raise Exception, 'Invalid url' if loaded_file_path.blank?

      CreatorFolderService.new(target_folder_path).call

      Zip.unicode_names = true

      buffer = Zip::OutputStream.write_buffer do |zip|
        zip.put_next_entry(File.basename(loaded_file_path))
        export = File.open(loaded_file_path, 'r').read
        zip.write export
      end

      file_path = File.join(building_path(target_folder_path), "#{File.basename(loaded_file_path, '.')}.zip")

      File.open(file_path, 'wb') { |f| f.write(buffer.string) }

      file_path
    end
  end
end
