class AttacksController < ApplicationController
  before_filter :set_attack, only: [:show, :edit]
  def index
  end

  def new
    @vault_hunter = VaultHunter.find(params[:vh])
    @attack = Attack.new
    render :show, layout: false, locals: {attack: @attack}
  end

  def create
    if params[:parent] != nil and params[:parent] != ""
      skill = params[:parent]
    else
      skill = nil
    end
    name = "Custom Attack"
    if skill != nil
      parent = Skill.find(skill)
      if parent != nil
        name = parent.name
      end
    end
    @attack = Attack.create(name: name, vault_hunter_id: params[:vh], totalpool: 0, basepool:0, otherpool:0, dmg: 0, misc: "", skill_id: skill)
    if params[:mode] == "edit"
      render:edit, layout: false, locals: {attack: @attack}
    else
      render :show, layout: false, locals: {attack: @attack}
    end
  end

  def batch
    if params[:attacks] != nil
      params[:attacks].each do |key, value|
        Attack.find(key).update(value)
      end
    end
    render inline: "ok", layout: false
  end

  def show
    render :show, layout: false, locals: {attack: @attack}
  end

  def edit
    render :edit, layout: false, locals: {attack: @attack}
  end

  def update
  end

  def destroy
    if params[:confirm] == "yes"
      Attack.destroy(params[:id])
      render inline: "destroyed", layout: false
    else
      render inline: "no confirm", layout: false
    end
  end
  
  private
    def set_attack
      @attack = Attack.find(params[:id])
    end
end
