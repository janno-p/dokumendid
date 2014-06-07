class SessionController < ApplicationController
  def sign_in
    @username = params[:username]
    if request.post? then
      user = UserAccount.authenticate(@username, params[:password])
      if user then
        session[:user_id] = user.user_account
        redirect_to root_path
      else
        flash.now[:notice] = "Vigane kasutajanime ja parooli kombinatsioon"
      end
    end
  end

  def sign_out
    session[:user_id] = nil
    flash[:notice] = "Välja logitud"
    redirect_to sign_in_path
  end
end
