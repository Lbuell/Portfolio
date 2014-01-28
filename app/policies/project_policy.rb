class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
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

  def approve?
    @user.editor?
  end
end
