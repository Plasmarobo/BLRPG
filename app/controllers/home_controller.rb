class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:pals]
  def dashboard
  end

  def about
  end

  def pals
  end
end
