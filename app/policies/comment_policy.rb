class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment


  def update?
    user.author? or user.editor?
  end

  def create

  return unless @user.present?
    @user.editor? or @user.author?
  end

  def destroy?
    return unless @user.present?
    user.editor?
  end

  def publish?
    return unless @user.present?
    user.editor?
  end
  def approve?
    return unless @user.present?
    user.editor?
  end

end
