module SessionsHelper

  # 전달받은 사용자로 로그인한다
  def log_in(user)
    session[:user_id] = user.id
  end

  # 사용자 세션을 영구적으로 설정한다
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 전달받은 사용자가 로그인을 완료한 사용자이면 true를 반환한다
  def current_user?(user)
    user == current_user
  end

  # 기억 토큰 cookie에 대응하는 사용자를 반환한다
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 사용자가 로그인한 상태이면 true, 그렇지 않으면 false를 반환한다
  def logged_in?
    !current_user.nil?
  end

  # 영구 세션을 파기한다
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 현재 사용자를 로그아웃 시킨다
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 기억한 URL(또는 기본값)으로 리다이렉트한다
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # 접속하고자 한 URL을 기억해둔다
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
