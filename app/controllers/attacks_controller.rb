class AttacksController < ApplicationController
  def index
  end

  def new
    @vault_hunter = VaultHunter.find(params[:vh])
    @attack = Attack.new
    render layout: nil
  end

  def create
    
  end

  def batch
    params[:attacks].each do |key, value|
      Attack.find(key).update(value)
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
