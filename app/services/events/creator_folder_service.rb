module Events
  class CreatorFolderService
    include Events

    attr_reader :folder_name

    def initialize(*args)
      @folder_name = args[0]
    end

    def call
      dir_path = building_path(folder_name)

      Dir.mkdir(dir_path) unless Dir.exist?(dir_path)

      dir_path
    end
  end
end

