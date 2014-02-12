class PostsController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, :with => :record_not_found
  before_filter :authenticate_user!, except: [:index, :show]
  #before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @posts = Post.all
    @commentable = @post
    @comments = @commentable.comments
    @comment = Comment.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize @post
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if current_user != @post.author && current_user.role != "editor"
      redirect_to posts_url, alert: 'That shit aint yours!'
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
     authorize @post
     if @post.save
      flash[:notice] = "Post Added!"
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
     @post = Post.find(params[:id])
     if @post.update_attributes(post_params)
      flash[:notice] = "Post was successfully updated."
      respond_to do |format|
        format.html { redirect_to posts_url }
        format.js
      end
    else
      render :edit
    end
  end

  def publish
    @post = Post.find(params[:id])
    @post.published = true
    @post.save
    redirect_to posts_url, notice: 'Well done, you did it!'
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :published, :author_id)
    end
end
