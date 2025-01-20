class CommentsController < ApplicationController
  before_action :set_post

  # GET /posts/:post_id/comments
  def index
    render json: @post.comments, include: :user
  end

  # POST /posts/:post_id/comments
  def create
    comment = @post.comments.new(comment_params)
    comment.user = current_user # Asegúrate de tener un método para identificar al usuario actual

    if comment.save
      render json: comment, status: :created, include: :user
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:post_id/comments/:id
  def destroy
    comment = @post.comments.find(params[:id])
    if comment.user == current_user
      comment.destroy
      head :no_content
    else
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
