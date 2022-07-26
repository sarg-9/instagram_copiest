# frozen_string_literal: true

# Posts Helper
module PostsHelper
  def already_liked(id)
    return true if Like.find_by(post_id: id, user_id: current_user.id)
  end

  def get_like_id(id)
    Like.find_by(post_id: id, user_id: current_user.id)
  end

  def get_like_count(id)
    check = Like.where(post_id: id)
    check.count
  end
end
