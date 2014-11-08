class ProficiencyTemplatesController < ApplicationController
  def index
  end

  def new
  end

  def list
    @proficiencies = ProficiencyTemplate.all
    respond_to do |format|
      format.html {render layout: nil}
      format.json
    end
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
