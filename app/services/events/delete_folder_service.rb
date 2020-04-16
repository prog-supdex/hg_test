module Events
  class DeleteFolderService
    include Events

    attr_reader :folder_path_for_destroy

    def initialize(*args)
      @folder_path_for_destroy = args[0]
    end

    def call
      return false unless Dir.exist?(folder_path_for_destroy)

      FileUtils.remove_dir(folder_path_for_destroy, true)
    end
  end
end
