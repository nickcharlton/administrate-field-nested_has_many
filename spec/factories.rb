FactoryBot.define do
  factory :school do
    sequence(:name) { |i| "School ##{i}" }
  end

  factory :student do
    sequence(:name) { |i| "Student ##{i}" }
  end
end
