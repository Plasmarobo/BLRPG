class HuntersController < ApplicationController
  before_filter :set_vault_hunter, only: [:build, :show, :share, :edit, :update, :delete, :skills, :addskill,  :potentialskills, :potentialproficiencies, :verify]

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
      flash[:notice] = "New hunter #{@vault_hunter.name} created"
      redirect_to action: :show, id: @vault_hunter.id
    else  
      flash[:alert] = "Something went wrong"
      redirect_to action: :new
    end
  end
  
  def build
    
  end

  def edit
    if current_user == @vault_hunter.user
      respond_to do |format|
        format.html
        format.json
      end
    else
      redirect_to '/'
    end
  end

  def show
  end
  
  def update
    if current_user == @vault_hunter.user
      
      if params[:proficiencies] != nil
        params[:proficiencies].each do |key, value|
          if not @vault_hunter.proficiencies.find(key).nil?
            Proficiency.find(key).update(value)
          end
        end
      end
      
      if params[:skills] != nil
        params[:skills].each do |key, value|
          if not @vault_hunter.skills.find(key).nil?
            Skill.find(key).update(value)
          end
        end
      end
      
      if params[:minions] != nil
        params[:minions].each do |key, value|
          if not @vault_hunter.skills.find(key).nil?
            Minion.find(key).update(value)
          end
        end
      end

      update_set = vault_hunter_params
      
      if not update_set[:level].nil?
        #Recompute totals
        @vault_hunter.recompute_totals(update_set[:level])
      end
      if @vault_hunter.update(update_set)
        render inline: "ok", layout: false
      else
        render inline: "failed", layout: false
      end
    else
      render inline: "failed", layout: false
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
      if not @vault_hunter.set_proficiency(candidate.id, candidate.points) then
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
  
  def addskill
    skill = SkillTemplate.find(params[:skill_template_id])
    if (skill != nil)
      if @vault_hunter.meets_prereq?(skill)
        if skill.instance(@vault_hunter)
          render html: "Success", status: 201
        else
          render html: "Failure", status: 500
        end
      else
        render html: "Prerequisite not met", status: 406
      end
    else
      render html: "Unknown Skill", status: 400
    end
  end
  
  def dropskill
  end
  
  def addproficiency
  end
  
  def dropproficiency
  end
  
  def buyproficiency
  end
  
  def sellproficiency
  end

  def list
    @vault_hunters = current_user.vault_hunters
    render :list
  end

  def skills
    @skills = @vault_hunter.skills 
    render partial: :skill_list, locals: {skills: @skills, function: "add_skill"}
  end

  #All skills who's prerequsties are met
  def potentialskills
    @skills = SkillTemplate.all.to_a
    @skills.select! do |skill|
      (!@vault_hunter.has_skill?(skill.name)) and @vault_hunter.meets_prereq?(skill)
    end
    render partial: 'skills/template_list', layout: false, locals: {skills: @skills}
  end
  
  def potentialproficiencies
    @proficiencies = ProficiencyTemplate.all.to_a
    @proficiencies.select! do |prof|
      (!@vault_hunter.has_proficiency?(prof.name))
    end
    render partial: 'proficiencies/template_add', layout: false, locals: {proficiencies: @proficiencies}
  end

  private
    def vault_hunter_params
      params.require(:vault_hunter).permit(:name, 
                                          :level, 
                                          :user_id, 
                                          :age, 
                                          :eyes,
                                          :hair,
                                          :skin,
                                          :race_id, 
                                          :height, 
                                          :weight, 
                                          :toughness, 
                                          :wounds,
                                          :loot, 
                                          :money,
                                          :description,
                                          :background,
                                          :traits,
                                          :flaws)
    end
    
    def skill_params
      params.require(:skill_template_id)
    end
    
    def set_vault_hunter
      @vault_hunter = VaultHunter.find(params[:id])
    end
end
