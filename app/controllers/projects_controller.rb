class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
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
    respond_to do |format|
      if @project.save
        #current_user.projects << @project
        format.html { redirect_to projects_path, notice: 'You did it!' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { redirect_to projects_path, notice: 'Not sure what you were thinking there buddy' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @project = Project.find(params[:id])
    @commentable = @project
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def edit
    authorize @project

  end

  def update
    @project = Project.find(params[:id])
    authorize @project

    if @project.update_attributes(project_params)
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
      format.json { head :no_content }
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
