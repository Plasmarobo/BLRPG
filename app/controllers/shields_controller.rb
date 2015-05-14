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
  
  def update
    params.require(:batch).each do |key, updates|
      shield = ShieldInstance.find(key)
      if shield != nil 
        if shield.checkOwner(current_user)
          updates = ActionController::Parameters.new(updates).permit(:current_capacity,
                                    :in_use)
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
  
  def instance
  end
end
