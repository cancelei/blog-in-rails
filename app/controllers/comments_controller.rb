class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params.merge(post: @post))
    if @comment.save
      redirect_to [@post.user, @post], notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id) # Add other comment attributes if any
  end
end
