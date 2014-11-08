module HuntersHelper

  def proficiency_attribute(vault_hunter, proficiency)
    attrib = vault_hunter.find_attribute_by_name(proficiency.attribute_name)
    "#{attrib.value} [#{attrib.short}]"
  end
end
