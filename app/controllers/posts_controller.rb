class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy, :like]

  # GET /posts
  def index
    posts = Post.includes(:comments, :user)
                .order(created_at: :desc)
                .page(params[:page])
                .per(params[:per_page] || 10)

    render json: posts, include: {
      comments: {},
      user: { only: [:id, :name, :image] }
    }, meta: {
      total_pages: posts.total_pages,
      current_page: posts.current_page,
      total_count: posts.total_count
    }
  end


  # GET /posts/:id
  def show
    render json: @post, include: :comments
  end

  # POST /posts
  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/:id
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:id
  def destroy
    @post.destroy
    head :no_content
  end

  # POST /posts/:id/like
  def like
    @post.increment!(:likes)
    render json: @post
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :description, :user_id)
  end
end
