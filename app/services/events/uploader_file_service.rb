module Events
  class UploaderFileService
    include Events

    attr_reader :upload_file_url, :target_folder

    def initialize(*args)
      @upload_file_url = args[0]
      @target_folder = args[1]
    end

    def call
      tempfile = Down.download(upload_file_url)

      if target_folder.blank?
        file_path = File.join(FOLDER_PATH, tempfile.original_filename)

        FileUtils.mv(tempfile.path, file_path)

        return file_path
      end

      CreatorFolderService.new(target_folder).call

      file_path = File.join(building_path(target_folder), tempfile.original_filename)

      FileUtils.mv(tempfile.path, file_path)

      file_path
    end
  end
end
