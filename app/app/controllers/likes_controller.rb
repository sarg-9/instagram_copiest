# frozen_string_literal: true

# Likes Controller
class LikesController < ApplicationController
  def create
    like = Like.new
    like.user_id = current_user.id
    like.post_id = params[:post_id]
    if like.save
      redirect_to user_post_path(current_user.id, params[:post_id]), notice: 'Liked :)'
    else
      redirect_to current_user, notice: 'Failed to like -_-'
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    if like.present?
      like.destroy
      redirect_to user_post_path(current_user.id, params[:post_id]), notice: 'un-Liked :('
    else
      redirect_to current_user, notice: 'Failed to unlike -_-'
    end
  end

  private

  def user_params
    params.require(:likes).permit(:id, :user_id, :post_id)
  end
end
