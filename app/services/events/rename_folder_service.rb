module Events
  class RenameFolderService
    include Events

    attr_reader :path_to_directory, :new_name_folder

    def initialize(*args)
      @path_to_directory = File.dirname(args[0])
      @new_name_folder = args[1]
    end

    def call
      raise Exception, 'Directory is not exists' unless Dir.exist?(path_to_directory)
      raise Exception, 'Invalid folder name' if new_name_folder.blank?

      dir_path = File.join(Pathname.new(path_to_directory).parent, new_name_folder)

      FileUtils.mv(path_to_directory, dir_path)

      dir_path
    end
  end
end

