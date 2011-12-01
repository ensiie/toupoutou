class HomeController < ApplicationController
  def index
    render :text => "Hello #{params[:name].try(:capitalize) || 'World'} !"
  end
end
