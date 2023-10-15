class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create

    if @like.save
      redirect_to post_path(@post), notice: 'Liked!'
    else
      redirect_to post_path(@post), alert: 'Error liking post.'
    end
  end
end
