module Events
  class ConverterHtmlToPdfService
    include Events

    attr_reader :url_html_file, :target_folder_path

    def initialize(*args)
      @url_html_file = args[0]
      @target_folder_path = args[1]
    end

    def call
      raise Exception, 'Invalid path to file' if url_html_file.start_with?('http', 'https') || !File.exist?(url_html_file)

      pdf = WickedPdf.new.pdf_from_html_file(url_html_file)

      CreatorFolderService.new(target_folder_path).call

      file_path = File.join(building_path(target_folder_path), "#{File.basename(url_html_file, '.')}.pdf")

      File.open(file_path, 'wb') { |f| f.write(pdf) }

      file_path
    end
  end
end
