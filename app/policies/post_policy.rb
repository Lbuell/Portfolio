class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def create?
    user.author? or user.editor?
  end

  def update?
    user.author? or user.editor?
  end

  def destroy?
    user.editor?
  end

  def publish?
    user.editor? or not post.published?
  end
end
