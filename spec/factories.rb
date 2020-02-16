FactoryBot.define do
  factory :school do
    sequence(:name) { |i| "School ##{i}" }
  end

  factory :student, class: Foo::Student do
    sequence(:name) { |i| "Student ##{i}" }
  end
end
