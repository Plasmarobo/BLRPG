class VaultHunter < ActiveRecord::Base
    belongs_to :user
    has_many :skills
    has_many :proficiencies
    has_many :attacks
end
