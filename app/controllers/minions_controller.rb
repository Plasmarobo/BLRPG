class MinionsController < ApplicationController
  before_filter :set_minion, only: [:show, :edit, :destroy]
  
  def index
  end
  
  def new
    @vault_hunter = VaultHunter.find(params[:vh])
    @minion = Minion.new
    render :show, layout: false, locals: {minion: @minion}
  end

  def create
    name = "CL4P-TP"
    @minion = Minion.create(name: name, vault_hunter_id: params[:vh], description: "Helllooooooo travelers!")
    if params[:mode] == "edit"
      render :edit, layout: false, locals: {minion: @minion}
    else
      render :show, layout: false, locals: {minion: @minion}
    end
  end

  def batch
    if params[:minions] != nil
      params[:minions].each do |key, value|
        Minion.find(key).update(value)
      end
    end
    render inline: "ok", layout: false
  end

  def show
    render :show, locals: {minion: @minion}
  end

  def edit
    render :edit, locals: {minion: @minion}
  end

  def update
  end

  def destroy
    if params[:confirm] == "yes"
      Minion.destroy(params[:id])
      render inline: "destroyed", layout: false
    else
      render inline: "no confirm", layout: false
    end
  end
  
  private
    def set_minion
      @minion = Minion.find(params[:id])
    end
    
    def minion_params
      params.require(:minion).permit(:name, :description, :vault_hunter_id)
    end
end
