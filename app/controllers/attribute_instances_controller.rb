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

  protected

    def attribute_instance_params
      params.require(:attribute_instance).permit(:name, 
                                                :value,
                                                :short,
                                                :vault_hunter_id,
                                                :id)
    end
end
