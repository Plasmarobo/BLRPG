class GearController < ApplicationController
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
    gear = GearInstance.find(params[:id])
    if (gear == nil)
      render html: "Unkown item", status: 400
    else
      gear.destroy()
      render html: "Deleted", status: 200
    end
  end
  
  def update
    render html: "Success", status: 200
  end

  
end
