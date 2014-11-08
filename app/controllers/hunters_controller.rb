class HuntersController < ApplicationController
  before_filter :select_vault_hunter, except: [:new, :list]
  
  def new
    @vault_hunter = VaultHunter.new  
    render 'player/sheet'
  end

  def view
    render 'player/sheet'
  end

  def edit
    render 'player/sheet'
  end
  
  def update
    
  end

  def delete
    
  end
  

  def list
    @vault_hunters = VaultHunter.all
    render :list
  end
  
  private
    def vault_hunter_params
      params.require('vault_hunter').permit(:name, :level, :user_id, :age, :race, :height, :weight, :toughness, :wounds, :shield, :current_shield, :loot, :money, :level)
    end
    
    def select_vault_hunter
      @vault_hunter = VaultHunter.find_by_id(params.id)
    end
end
