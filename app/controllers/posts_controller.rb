class PostsController < ApplicationController

  before_action :authorize, except: [:index]

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    post = Post.create(user_id: current_user.id,
                       title: params[:title],
                       content: params[:content])
    flash[:notice] = "글이 작성되었습니다."
    redirect_to "/"
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(user_id: current_user.id,
                title: params[:title],
                content: params[:content])
    flash[:notice] = "글이 수정되었습니다."
    redirect_to "/posts/#{post.id}"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:alert] = "글이 삭제되었습니다."
    redirect_to "/"
  end
end
