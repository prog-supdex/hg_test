module Events
  class ParseSupCom2ReplayService
    include Events

    attr_reader :path_to_replay, :target_folder_path

    def initialize(*args)
      @path_to_replay = args[0]
      @target_folder_path = args[1]
    end

    def call
      raise Exception, 'Invalid path to file' if path_to_replay.start_with?('http', 'https') || !File.exist?(path_to_replay)

      replay_info = SupCom2ReplayParser.call(path_to_replay)

      CreatorFolderService.new(target_folder_path).call

      file_path = File.join(building_path(target_folder_path), "#{File.basename(path_to_replay, '.')}.txt")

      File.open(file_path, 'w+') { |f| f.write(replay_info) }

      file_path
    end
  end
end
