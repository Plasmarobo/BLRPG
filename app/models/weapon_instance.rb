class WeaponInstance < ActiveRecord::Base
  belongs_to :vault_hunter
  belongs_to :weapon_template
end
