class HuntersController < ApplicationController
  before_filter :set_vault_hunter, only: [:show, :edit, :update, :delete, :skills, :potentialskills]
  helper HuntersHelper
  def new
    @vault_hunter = VaultHunter.new  
    @vault_hunter.user = current_user
  end
  
  def create
    @vault_hunter = VaultHunter.new(vault_hunter_params)
    @vault_hunter.user = current_user
    if @vault_hunter.save
      flash[:notice] = "New hunter #{@vault_hunter.name} created"
      redirect_to action: :show, id: @vault_hunter.id
    else  
      flash[:alert] = "Something went wrong"
      redirect_to action: :new
    end
  end

  def show
    render :sheet
  end

  def edit
    render :sheet
  end
  
  def update
    update_set = vault_hunter_params
    @vault_hunter.update(update_set)
    if @vault_hunter.save
      render inline: "ok", layout: false
    else
      render inline: "failed", layout: false
    end
  end

  def delete
    
  end
  

  def list
    @vault_hunters = VaultHunter.all
    render :list
  end

  def skills
    @skills = @vault_hunter.skills 
    render layout: nil
  end

  #All skills who's prerequsties are met
  def potentialskills
    @skills = Skill_Templates.all
    @skills.select! do |skill|
      @vault_hunter.meets_prereq(skill)
    end
    render layout: nil
  end

  private
    def vault_hunter_params
      params.require(:vault_hunter).permit(:name, 
                                          :level, 
                                          :user_id, 
                                          :age, 
                                          :race, 
                                          :height, 
                                          :weight, 
                                          :toughness, 
                                          :wounds, 
                                          :shield, 
                                          :current_shield, 
                                          :loot, 
                                          :money, 
                                          :level,
                                          :current_skill_points,
                                          :current_proficiency_points)
    end
    
    def set_vault_hunter
      @vault_hunter = VaultHunter.find(params[:id])
    end
end
