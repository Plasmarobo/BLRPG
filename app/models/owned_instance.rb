class OwnedInstance < ActiveRecord::Base
  self.abstract_class = true
  belongs_to :vault_hunter
  # Must have Vault Hunter Id
  # Abstract
  def checkOwner(user)
    vh = VaultHunter.find(self.vault_hunter_id)
    return vh.user == user
  end
end