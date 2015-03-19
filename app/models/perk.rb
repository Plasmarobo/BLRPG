class Perk < ActiveRecord::Base
  has_many :modifier_templates
  has_many :modifiers
end
