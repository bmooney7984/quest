class Quest < ApplicationRecord
  has_many :quest_assignments
  accepts_nested_attributes_for :quest_assignments
end
