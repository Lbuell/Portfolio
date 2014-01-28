class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
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
    @posts = Post.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
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
     respond_to do |format|
      if @post.save
        current_user.posts << @post
        format.html { redirect_to posts_path, notice: 'You did it!' }
        format.json { render action: 'show', status: :created, location: @post }
        current_user.posts << @post
      else
        format.html { redirect_to posts_path, notice: 'Not sure what you were thinking there buddy' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
     end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
     @post = Post.find(params[:id])
     respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to @post, notice: 'Holy crap updated!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
    if current_user != @post.author && current_user.role != "editor"
      redirect_to posts_url, alert: 'Not yours sucka!'
      else
        respond_to do |format|
        format.html { redirect_to posts_url }
        format.json { head :no_content }
      end
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
