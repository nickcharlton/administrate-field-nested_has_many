class School < ApplicationRecord
  has_many :students, class_name: "Foo::Student"
  accepts_nested_attributes_for :students, allow_destroy: true
end
