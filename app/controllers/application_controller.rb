class ApplicationController < ActionController::Base
  protect_from_forgery
  def confirmSession
    if session[:userid] == nil
      redirect_to controller: "logins" , action: "new"
    end
  end
end
