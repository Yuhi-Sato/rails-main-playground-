class Api::V1::PostsController < Api::BaseController
  def index
    scope = authorized_scope(Post.all).recent
    scope = scope.search_text(params[:q]) if params[:q].present?

    @pagy, @posts = pagy(scope, limit: 20)

    render json: PostResource.new(@posts, params: { host: request.base_url }).serialize
  end

  def show
    post = Post.kept.find_by!(slug: params[:id])
    authorize! post
    render json: PostResource.new(post, params: { host: request.base_url }).serialize
  end
end
