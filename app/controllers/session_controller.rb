class SessionController < ApplicationController
  def sign_in
    @username = params[:username]
    if request.post? then
      user = UserAccount.authenticate(@username, params[:password])
      if user then
        unless user.employee? then
          flash.now[:notice] = "Dokumentide süsteemi kasutamine on lubatud ainult töötajatele."
        else
          session[:user_id] = user.user_account
          redirect_to root_path
        end
      else
        flash.now[:notice] = "Vigane kasutajanime ja parooli kombinatsioon"
      end
    end
  end

  def sign_out
    reset_session
    flash[:notice] = "Välja logitud"
    redirect_to sign_in_path
  end
end
