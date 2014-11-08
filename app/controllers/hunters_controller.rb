class HuntersController < ApplicationController
  before_filter :set_vault_hunter, only: [:show, :edit, :update, :delete]
  helper HuntersHelper
  def new
    @vault_hunter = VaultHunter.new  
    @vault_hunter.user = current_user
    render :edit
  end

  def show
    render :sheet
  end

  def edit
    render :edit
  end
  
  def update
    flash[:notice] = "Updates saved!"
    redirect_to action: :edit
  end

  def delete
    
  end
  

  def list
    @vault_hunters = VaultHunter.all
    render :list
  end
  
  private
    def vault_hunter_params
      params.require(:vault_hunter).permit(:name, :level, :user_id, :age, :race, :height, :weight, :toughness, :wounds, :shield, :current_shield, :loot, :money, :level)
    end
    
    def set_vault_hunter
      @vault_hunter = VaultHunter.find(params[:id])
    end
end
