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

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
