class MinionInstance < OwnedInstance
  self.table_name = :minion_instances
  belongs_to :minion_template
end
