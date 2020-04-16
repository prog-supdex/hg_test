module Events
  class UnzipperService
    include Events

    attr_reader :url_file_to_unzip, :target_folder_path

    def initialize(*args)
      @url_file_to_unzip = args[0]
      @target_folder_path = args[1]
    end

    def call
      loaded_file_path =
        if url_file_to_unzip.start_with?('http', 'https')
          UploaderFileService.new(url_file_to_unzip).call
        elsif File.exist?(url_file_to_unzip)
          url_file_to_unzip
        end

      raise Exception, 'Invalid url' if loaded_file_path.blank?

      CreatorFolderService.new(target_folder_path).call

      dir_path = building_path(target_folder_path)
      file_path = nil

      Zip::File.open(loaded_file_path) do |zip_file|
        zip_file.each_with_index do |file, index|
          next unless index.zero?

          file_path = File.join(dir_path, file.name)

          zip_file.extract(file, file_path) unless File.exist?(file_path)
        end
      end

      file_path
    end
  end
end
