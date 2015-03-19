class ConsumableInstance < ActiveRecord::Base
  belongs_to :consumable_template
  belongs_to :vault_hunter
  has_many :modifiers
end
