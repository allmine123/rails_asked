class UsersController < ApplicationController
  def index
  end

  def login
  end

  def loginprocess
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

  def logout
    session.clear
    flash[:notice] = "잘가유"
    redirect_to '/'
  end

  def new
  end

  def create
    #
    # #1. emial 검증  .find_by(email: 값)
    # unless User.find_by(email: params[:email])
    #   #1-1. 맞으면, 비밀번호 확인
    #   #1-1-1. 비밀번호가 같으면 가입
    #   if params[:password] == params[:password_confirmation]
    #   user = User.create(username: params[:username], email: params[:email], password: params[:password])
    #   flash[:notice] = "#{user.username}님 회원가입을 축하합니다."
    #   redirect_to "/"
    #   else#1-1-2. 비밀번호가 틀리면 flash로 비밀번호가 일치하지 않습니다. redirect_to :back
    #     flash[:alert] = "비밀번호가 일치하지 않습니다."
    #     redirect_to :back
    #   end
    # #1-2. 틀리면, flash로 가입된 이메일입니다. redirect_to :back
    # else
    #   flash[:alert] = "이미 가입된 이메일입니다."
    #   redirect_to :back
    # end

    unless User.find_by(email: params[:email])
      @user = User.new(username: params[:username], email: params[:email],
                          password: params[:password],
                          password_confirmation: params[:password_confirmation])
      if @user.save
        #가입이 되면, ture + 저장이 되고,
        flash[:notice] = "#{@user.username}님 회원가입을 축하합니다."
        redirect_to '/'
      else
        #비밀번호가 달라서 가입이 안되면, false + 저장이 안됨
        flash[:alert] = "비밀번호가 일치하지 않습니다."
        redirect_to :back
      end
    else
      flash[:alert] = "이미 가입된 이메일입니다."
      redirect_to :back
    end

  end
end
