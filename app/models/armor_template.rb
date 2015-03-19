class ArmorTemplate < ActiveRecord::Base
  has_many :modifier_templates
end
