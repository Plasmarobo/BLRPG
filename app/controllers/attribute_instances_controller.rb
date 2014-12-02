class AttributeInstancesController < ApplicationController

  def create
    AttributeInstance.create(attribute_instance_params)
  end

  def update
  end

  def batch
    if params[:attribute_instances] != nil
      params[:attribute_instances].each do |key, value|
        AttributeInstance.find(key).update({value: value})
      end
    end
    render inline: "ok", layout: false
  end
  
  def validate_batch
    valid = true
    if params[:attribute_instances] != nil
      params[:attribute_instances].each do |key, value|
        target = AttributeInstance.find(key)
        delta = value.to_i - target.value.to_i
        if delta <= target.vault_hunter.current_attribute_points
          target.vault_hunter.current_attribute_points -= delta
          target.vault_hunter.save
          target.update({value: value})
        else
          valid = false
        end
      end
    end
    if valid
      render inline: "ok", layout: false
    else
      render inline: "fail", layout: false, status: :expectation_failed
    end
  end

  protected

    def attribute_instance_params
      params.require(:attribute_instance).permit(:name, 
                                                :value,
                                                :short,
                                                :vault_hunter_id,
                                                :id)
    end
end
