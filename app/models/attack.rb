class Attack < ActiveRecord::Base
  belongs_to :vault_hunter
  has_one :skill
end
