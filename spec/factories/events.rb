FactoryBot.define do
  factory :event do
    name { 'Создание папки' }
    event_type { :creator_folder }
    param1 { nil }
    param2 { nil }
  end
end
