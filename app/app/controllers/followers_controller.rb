# frozen_string_literal: true

# followers controller
class FollowersController < ApplicationController
  before_action :current_user_followers, only: %i[index]
  before_action :confirmed_users, only: %i[follow]

  def new
    follower = Follower.new
    follower.user_id = follower_params[:user_id]
    follower.follower_id = current_user.id
    follower.friend = false
    if follower.save
      redirect_to current_user, notice: 'Follow request Sent'
    else
      redirect_to current_user, notice: 'Follow request cannot be sent'
    end
  end

  def create
    @follower = Follower.find_by(user_id: current_user.id, follower_id: params[:user_id])
    if @follower.friend == false
      @follower.friend = true
      redirect_to current_user, notice: 'Follow Request Accepted Successfully.' if @follower.save!
    else
      redirect_to current_user, notice: 'Already Following'
    end
  end

  def destroy
    follower = Follower.find_by(follower_params)
    if follower.present?
      follower.destroy
      redirect_to current_user, notice: 'canceled request'
    else
      redirect_to current_user, notice: 'can not cancel request'
    end
  end

  def follow; end

  private

  # Use callbacks to share common setup or constraints between actions.

  def confirmed_users
    @users = User.where.not(confirmed_at: nil)
  end

  def current_user_followers
    @followers = Follower.where(user_id: current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def follower_params
    params.permit(:user_id, :follower_id, :id, :friend)
  end
end
