class PostsController < ApplicationController

  before_action :authorize, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    #post = Post.create(user_id: current_user.id,title: params[:title], content: params[:content])
    #post = Post.create(post_params)
    @post = current_user.posts.new(post_params)
    @post.save
    flash[:notice] = "글이 작성되었습니다."
    redirect_to "/"
  end

  def show
    #@post = Post.find(params[:id])
  end

  def edit
    #@post = Post.find(params[:id])
  end

  def update
    #post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = "글이 수정되었습니다."
    redirect_to "/posts/#{post.id}"
  end

  def destroy
    @post.destroy
    flash[:alert] = "글이 삭제되었습니다."
    redirect_to "/"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    #params.permit(:title, :content).merge(user_id: current_user.id)
    params.permit(:title, :content)
  end

end
