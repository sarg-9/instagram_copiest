# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  after_action :authorize_post, only: %i[new]
  before_action :authorize_post, only: %i[edit destroy update]

  def show
    @posts = Post.where(id: params[:id], user_id: current_user.id)
    @comments = Comment.where(post_id: params[:id])
    authorize @posts
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to current_user, notice: 'Post was successfully created.'
    else
      redirect_to current_user, notice: 'Post was not created.'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to user_post_path(current_user.id, @post.id), notice: 'Post was successfully updated.'
    else
      redirect_to current_user, notice: 'Failed to update the post'
    end
  end

  def destroy
    if @post.destroy
      redirect_to current_user, notice: 'Post was successfully destroyed.'
    else
      redirect_to current_user, notice: 'Post was not destroyed.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    authorize @post
  end

  def post_params
    params.require(:post).permit(:caption, :user_id, images: [])
  end
end
