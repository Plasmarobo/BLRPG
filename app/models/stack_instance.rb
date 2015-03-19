class StackInstance < ActiveRecord::Base
  belongs_to :vault_hunter
  belongs_to :stack_template
  has_many :modifiers
end
