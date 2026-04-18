class PostsController < ApplicationController
  def index
    scope = authorized_scope(Post.all).recent
    scope = scope.search_text(params[:q]) if params[:q].present?
    @query = params[:q].to_s
    @pagy, @posts = pagy(scope)
  end

  def show
    @post = Post.kept.find_by!(slug: params[:id])
    authorize! @post
  end
end
