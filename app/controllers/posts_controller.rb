class PostsController < ApplicationController
  def index
    scope = authorized_scope(Post.all).recent
    @pagy, @posts = pagy(scope)
  end

  def show
    @post = Post.kept.find_by!(slug: params[:id])
    authorize! @post
  end
end
