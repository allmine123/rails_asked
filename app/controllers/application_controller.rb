class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #helper_method -> view에서 편하게 메소드 호출을 하려고
  helper_method :current_user
  def current_user
    #session에 저장되어 있는 경우,
    # @user를 찾아서 저장한다.
    # ||= 으로 저장하는 이유는 @user가 비어있는 경우에만 저장하기 위해서
      @user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
