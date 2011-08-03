class HomeController < ApplicationController
  layout "default"
  before_filter :authorize
  
  def index
  end
end
