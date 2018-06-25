class SessionsController < ApplicationController
  def new #login
  end

  def create #loginprocess
    #1. 이메일이  가입되었나
    user = User.find_by(email: params[:email])
    #1-1. 가입이 되었으면 비밀번호확인
    if user
      if user.authenticate(params[:password])
        #1-1-1. 비밀번호가 일치하면 로그인
        session[:user_id] = user.id
        flash[:notice] = "#{user.username}아 안녕"
        redirect_to '/'
        #1-1-2. 비밀번호가 다르면 flash메세지 + :back
      else
        flash[:alert] = "비밀번호가 다릅니다."
        redirect_to :back
      end
      #1-2. 가입이 안되어있으면, flash + 가입하는 곳으로
    else
      flash[:alert] = "가입되지 않은 이메일입니다."
      redirect_to '/signup'
    end
  end

  def destroy #logout
    session.clear
    flash[:notice] = "잘가유"
    redirect_to '/'
  end
end
