module HomeHelper
  def home_follow(id)
    Follower.find_by(user_id: id)
  end

  def home_follower(id)
    Follower.where(follower_id: id)
  end

  def home_following(id)
    check = Follower.where(follower_id: current_user.id, user_id: id)
    check.first
  end
end
