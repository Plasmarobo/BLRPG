class ArmorInstance < ActiveRecord::Base
  belongs_to :vault_hunter
  belongs_to :armor_template
  has_many :modifiers
end
