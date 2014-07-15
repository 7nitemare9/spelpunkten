# Posts Controller
class PostsController < ApplicationController
  require 'auth_helper'
  include AuthHelper
  #before_filter :is_admin, except: [:index, :show]

  def index
    if params[:id]
      @posts = Post.news.rotate(params[:id].to_i)
      render layout: false
    end
    @posts = Post.news
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to root_path
  end

  def update
    @post = Post.find(params[:id])
    redirect_to root_path if @post.update_attributes(post_params)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    redirect_to root_path if @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
