class MeleeWeaponTemplate < ActiveRecord::Base
  has_many :modifier_templates
end
