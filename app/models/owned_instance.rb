class OwnedInstance < ActiveRecord::Base
  self.abstract_class = true
  belongs_to :vault_hunter
  # Must have Vault Hunter Id
  # Abstract
  def checkOwner(user)
    vh = VaultHunter.find(self.vault_hunter_id)
    if vh.user_id == user.id
      return true
    else
      render html: "Current User not Onwer", status: 403
      return false
    end
  end
end