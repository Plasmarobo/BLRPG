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
      shield = Shield.find(key)
      if shield != nil 
        if shield.checkOwner(current_user)
          updates = updates.permit(:current_capacity,
                                    :in_use)
          shield.update(updates)
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
