class GearInstance < OwnedInstance
  self.table_name = :gear_instances
  has_many :modifiers, dependent: :destroy
  belongs_to :gear_template
end
