# frozen_string_literal: true

# User Controller
class UsersController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc)
    @followers = Follower.where(user_id: current_user.id)
  end

  def search
    @users = User.where('name ILIKE ?', "%#{params[:search]}%")
  end

  def edit; end

  def requests
    @followers = Follower.where(user_id: current_user.id)
  end

  def update
    if current_user.update(user_params)
      redirect_to current_user, notice: 'updated info'
    else
      redirect_to current_user, notice: 'could not update information'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :mobilenumber, :avatar, :public)
  end
end
