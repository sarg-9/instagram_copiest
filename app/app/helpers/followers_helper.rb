module FollowersHelper
  def follower_check(id)
    check = Follower.where(follower_id: current_user.id, user_id: id)
    check.first
  end

  def follower_return(id)
    check = Follower.where(follower_id: current_user.id, user_id: id)
    check.first
  end

  def following_check(id)
    check = Follower.where(follower_id: current_user.id, user_id: id)
    check.first
  end
end
