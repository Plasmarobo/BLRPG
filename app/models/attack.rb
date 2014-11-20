class Attack < ActiveRecord::Base
  belongs_to :vault_hunter
  belongs_to :skill
  belongs_to :attribute_instance
end
