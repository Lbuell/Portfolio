class ProjectsController < ApplicationController
  #before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @projects = Project.all

  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    if @project.save
      flash[:notice] = "Project Added!"
      respond_to do |format|
        format.html { redirect_to @project }
        format.js
      end
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @commentable = @project
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
    respond_to do |format|
      format.js
    end
  end

  def update
    @project = Project.find(params[:id])
    authorize @project

    if @project.update(project_params)
      flash[:notice] = "Project was successfully updated."
      respond_to do |format|
        format.html { redirect_to projects_url }
        format.js
      end
    else
      render :edit
    end
  end

  def approve
    @project = Project.find(params[:id])
    @comment.approved = true
    @comment.save
    redirect_to projects_url, notice: 'Well done, you did it!'
  end

  def destroy
    @project = Project.find(params[:id])
    authorize @project
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.js
    end
  end

private

  def project_params
    params.require(:project).permit(:name, :technologies_used)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
