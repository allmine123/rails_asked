class UsersController < ApplicationController
  def index
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts
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
