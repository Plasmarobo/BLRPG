class ShieldsController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def index
  end

  def card
  end
  
  def delete
    params.require(:id)
    shield = ShieldInstance.find(params[:id])
    if (shield == nil)
      render html: "Unkown item", status: 400
    else
      shield.destroy()
      render html: "Deleted", status: 200
    end
  end
  
  def update
    params.require(:batch).each do |key, updates|
      shield = ShieldInstance.find(key)
      if shield != nil 
        if shield.checkOwner(current_user)
          updates = ActionController::Parameters.new(updates).permit(:current_capacity,
                                    :in_use)
          updates[:in_use] = updates[:in_use] == "true" ? true : false
          shield.update(updates)
        else
          render html: "Current User not Owner", status: 403
          return
        end
      else
        render html: "Unknown shield #{key}", status: 400
        return
      end
    end
    render html: "Batch Accepted", status: 200
  end
  
  def card
    params.require(:id)
    @shield = ShieldTemplate.find(params[:id])
    @meta = {}
    @meta[:color] = "#CA9BCC"
    @meta[:title] = @shield.name
    @meta[:subtitle] = "It's like bugspray for bullets"
    render partial: 'shields/card', locals: {shield: @shield}, layout: 'layouts/card'
  end
  
  def instance
  end
end
