class Duration < ActiveRecord::Base
  belongs_to :skill_instance
  belongs_to :effect
  has_many :modifiers
end
