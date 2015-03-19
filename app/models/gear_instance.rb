class GearInstance < ActiveRecord::Base
  has_many :modifiers, dependent: :destroy
  belongs_to :vault_hunter
  belongs_to :gear_template
end
