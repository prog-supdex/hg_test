module Events
  class TreeToFileService
    include Events

    attr_reader :target_directory, :target_file

    def initialize(*args)
      @target_directory = args[0].presence || Dir.pwd
      @target_file = args[1]
    end

    def call
      raise Exception, 'Directory is not exists' unless File.directory?(target_directory)
      raise Exception, 'Filename is not exists' if target_file.blank?

      tree = TTY::Tree.new(target_directory)
      file_name = File.extname(target_file).present? ? target_file : "#{target_file}.txt"
      file_path = File.join(building_path, file_name)

      File.open(file_path, 'w+') { |f| f.write(tree.render) }

      file_path
    end
  end
end
