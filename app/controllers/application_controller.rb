# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  before_filter :authorize, :except => :sign_in

  protected

  def authorize
    @current_user = UserAccount.find_by_user_account(session[:user_id])
    unless @current_user then
      flash[:notice] = "Palun logi sisse"
      redirect_to controller: :session, action: :sign_in
    end
  end
end
