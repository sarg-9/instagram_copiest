# frozen_string_literal: true

# home controller
class HomeController < ApplicationController
  # before_action :authenticate_user!
  def index
    if user_signed_in?
      @users = User.where.not(confirmed_at: nil)
    else
      redirect_to new_user_registration_path
    end
  end
end
