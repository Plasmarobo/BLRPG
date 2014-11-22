class HuntersController < ApplicationController
  before_filter :set_vault_hunter, only: [:build, :show, :share, :edit, :update, :delete, :skills, :potentialskills]

  def new
    @vault_hunter = VaultHunter.new  
    @vault_hunter.user = current_user
  end
  
  def create
    @vault_hunter = VaultHunter.new(vault_hunter_params)
    @vault_hunter.set_default_values()
    @vault_hunter.user = current_user
    if @vault_hunter.save
      #default attributes
      @vault_hunter.create_default_attributes()
      flash[:notice] = "New hunter #{@vault_hunter.name} created"
      redirect_to action: :show, id: @vault_hunter.id
    else  
      flash[:alert] = "Something went wrong"
      redirect_to action: :new
    end
  end
  
  def build
    
  end

  def show
    if current_user == @vault_hunter.user
      respond_to do |format|
        format.html { render :sheet }
        format.json { render :view }
      end
    else
      redirect_to '/'
    end
  end

  def share
    render :share
  end

  def edit
    if current_user == @vault_hunter.user
      render :sheet
    else
      redirect_to '/'
    end
  end
  
  def update
    if current_user == @vault_hunter.user
      update_set = vault_hunter_params
      @vault_hunter.update(update_set)
      if @vault_hunter.save
        render inline: "ok", layout: false
      else
        render inline: "failed", layout: false
      end
    else
      render inline: "failed", layout: false
    end
  end
  
  def validate_attribute_changes
    result = true
    changed_attributes = params[:changed_attributes]
    changed_attributes.each do |attrib_change|
      if not @vault_hunter.improve_attribute(attrib_change.id, attrib_change.value) then
        result = false
      end
    end
    if result == true then
      render :inline, "success"
    else
      render :inline, "invalid"
    end
  end
  
  def validate_proficiency_changes
    result = true
    #Format: template_id
    new_proficiencies = params[:new_proficiencies]
    #Format: id, points
    changed_proficiencies = params[:changed_proficiencies]
    new_proficiencies.each do |candiate|
      if not @vault_hunter.add_proficiency(candidate) then
        result = false
      end
    end
    changed_proficiencies.each do |candiate|
      if not @vault_hunter.improve_proficiency(candidate.id, candidate.points) then
        result = false
      end
    end
    if result == true then
      render :inline, "success"
    else
      render :inline, "invalid"
    end
  end
  
  def validate_skill_changes
    result = true
    new_skills = params[:skills]
    new_skills.each do |candidate_id|
      candidate = SkillTemplate.find(candidate_id)
      if not @vault_hunter.add_skill(candidate) then
        result = false
      end
    end
    if result == true then
      render :inline, "success"
    else
      render :inline, "invalid"
    end
  end

  def delete
    if params[:confirm] == "yes"
      if current_user == @vault_hunter.user
        @vault_hunter.destroy
        redirect_to '/hunters/list', notice: "Destroyed #{@vault_hunter.name}"
      end
    end
  end
  

  def list
    @vault_hunters = current_user.vault_hunters
    render :list
  end

  def skills
    @skills = @vault_hunter.skills 
    render layout: nil
  end

  #All skills who's prerequsties are met
  def potentialskills
    @skills = SkillTemplate.all.to_a
    @skills.select! do |skill|
      (!@vault_hunter.has_skill?(skill)) and @vault_hunter.meets_prereq?(skill)
    end
    render 'skill_templates/list', layout: nil, locals: {skills: @skills}
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
                                          :current_proficiency_points,
                                          :description,
                                          :background,
                                          :traits,
                                          :flaws)
    end
    
    def set_vault_hunter
      @vault_hunter = VaultHunter.find(params[:id])
    end
end
