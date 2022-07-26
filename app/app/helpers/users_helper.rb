module UsersHelper
  def check_follower(id)
    Follower.find_by(user_id: id)
  end

  def return_follower(id)
    Follower.where(follower_id: id)
  end

  def check_following(id)
    Follower.find_by(follower_id: current_user.id, user_id: id, friend: true)
  end

  def follow_request_accepted(id)
    Follower.find_by(user_id: id, follower_id: current_user.id, friend: true)
  end

  def count_followers(id)
    check = Follower.where(user_id: id, friend: true)
    check.count
  end

  def check_request(id)
    check = Follower.find_by(user_id: current_user, follower_id: id)
    check.friend
  end
end
