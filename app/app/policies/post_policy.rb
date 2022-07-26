# frozen_string_literal: true

# post policy
class PostPolicy < ApplicationPolicy
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
    user.present? && user == record.user
  end

  def update?
    return true if user.present? && user == record.user
  end

  def destroy?
    return true if user.present? && user == record.user
  end
end