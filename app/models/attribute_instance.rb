class AttributeInstance < ActiveRecord::Base
  belongs_to :vault_hunter
  belongs_to :attribute_template
  
  def name
    self.attribute_template.name
  end
end
