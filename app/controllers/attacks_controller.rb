class AttacksController < ApplicationController
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
    @attack = Attack.create(name: name, vault_hunter_id: params[:vh], pool: 0, dmg: 0, misc: "", skill_id: skill)
    render :show, layout: false, locals: {attack: @attack}
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
  end

  def edit
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
end
