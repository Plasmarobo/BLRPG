class ShieldInstance < ActiveRecord::Base
  belongs_to :vault_hunter
  belongs_to :shield_template
  has_many :modifiers
end
