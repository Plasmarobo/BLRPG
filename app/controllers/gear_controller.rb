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
    params.require(:id)
    @gear = GearTemplate.find(params[:id])
    @meta = {}
    @meta[:color] = "#858585"
    @meta[:title] = @gear.name
    @meta[:subtitle] = "An integral gadget or upgrade"
    render partial: 'gear/card', locals: {gear: @gear}, layout: 'layouts/card'
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
