module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  #Log out current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
