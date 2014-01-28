class CommentsController < ApplicationController
  before_filter :load_commentable

  def index
    @comments = @commentable.comments
    authorize @comment
  end

  def new
    @comment = @commentable.comments.new
    #authorize @comment
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update_attributes(comment_params)
        if @comment.approved
          flash[:notice] = "Comment approved."
        else
          flash[:notice] = "Comment disapproved."
        end
      redirect_to @commentable
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @commentable }
      format.json { head :no_content }
    end
  end
private

  def load_commentable
    @resource, id = request.path.split('/')[1,2]
    @commentable = @resource.singularize.classify.constantize.find(id)
  end

  def comment_params
    params.require(:comment).permit(:content, :author, :approved,
     :author_email, :commentable_id)
  end
end
