class School < ApplicationRecord
  has_many :students
  accepts_nested_attributes_for :students
end
