class PostPolicy < ApplicationPolicy
  attr_reader :user, :post, :project

  def initialize(user, post)
    @user = user
    @post = post
  end

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
    @user.editor?
  end

end
