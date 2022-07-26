# frozen_string_literal: true

# comments controller
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  after_action :authorize_comment, only: %i[new]
  before_action :authorize_comment, only: %i[edit destroy update]

  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def edit; end

  def create
    comment = Comment.new(comment_params)
    authorize comment
    comment.content = comment_params[:content]
    comment.user_id = current_user.id
    comment.post_id = params[:post_id]
    if comment.save
      redirect_to user_post_path(params[:user_id], params[:post_id]),
                  notice: 'Comment was successfully created.'
    else
      redirect_to current_user, notice: 'Comment can not be blank. '
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to user_post_path(params[:user_id], params[:post_id]),
                  notice: 'updated comment'
    else
      redirect_to current_user, notice: 'Comment can not be updated.'
    end
  end

  def destroy
    if @comment.destroy
      redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Successfully destroyed.'
    else
      redirect_to current_user, notice: 'Comment can not be destroyed.'
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
