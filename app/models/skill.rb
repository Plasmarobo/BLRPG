class Skill < ActiveRecord::Base
    belongs_to :vault_hunter
    has_one: :skill_template
    
end
