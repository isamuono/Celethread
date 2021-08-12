module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    
    def connect
      self.current_user = find_verified_user
    end
    
    #def current_user
    #  if (user_id = session[:user_id])
    #    @current_user ||= User.find_by(id: user_id)
    #  elsif (user_id = cookies.signed[:user_id])
    #    user = User.find_by(id: user_id)
    #    if user && user.authenticated?(:remember, cookies[:remember_token])
    #      log_in user
    #      @current_user = user
    #    end
    #  end
    #end
    
    protected
    
    def find_verified_user
      if verified_user = User.find_by(id: session['user_id'])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
   
    def session
      cookies.encrypted[Rails.application.config.session_options[:key]]
    end
  end
end
