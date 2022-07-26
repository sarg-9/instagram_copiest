# frozen_string_literal: true

# comment policy
class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && user.id == record.user_id
  end

  def update?
    user.present? && user.id == record.user_id
  end

  def destroy?
    user.present? && ((user.id == record.user_id) || (user.id == record.post.user_id))
  end
end
