class ProficiencyInstance < ActiveRecord::Base
    belongs_to :proficiency_template
    belongs_to :vault_hunter
end
