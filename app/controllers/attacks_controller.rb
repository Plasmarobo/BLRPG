class AttacksController < ApplicationController
  def index
  end

  def new
    @vault_hunter = VaultHunter.find(params[:vh])
    @attack = Attack.new
    render :show, layout: false
  end

  def create
    
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
  end
end
