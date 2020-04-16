module Events
  FOLDER_PATH = Rails.root.join('public/events').freeze

  def call
    raise NotImplementedError, "#{self.class} не может ответить на: #{__method__}"
  end

  private

  def building_path(folder_path = nil)
    return FOLDER_PATH if folder_path.blank?

    File.join(FOLDER_PATH, folder_path)
  end
end
