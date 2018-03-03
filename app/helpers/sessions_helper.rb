module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id 
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
    set_current_user
  end

  def set_current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(remember_digest)
        sign_in user 
        @current_user = user
      end
    end
  end

  def current_user
    @current_user
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    session.delete(:user_id)
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
    @current_user = nil
  end
end
