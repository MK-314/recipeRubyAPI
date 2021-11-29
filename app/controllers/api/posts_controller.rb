module Api
  class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]

    # GET /posts
    def index
      if params[:thisaction].present?
        # [START] FIND BY USER ID
        if params[:thisaction] == "getByUserId"
          @post = Post.where("user_id = ?", params[:user_id])
          render json: @post
        end
        # [END] FIND BY USER ID
        # [START] COUNT POSTS BY USER ID
        if params[:thisaction] == "countPostsByUserId"
          @result = Post.where(user_id: params[:user_id]).count
          render json: { postNumber: @result }
        end
        # [END] COUNT POSTS BY USER ID
      else
        # [START] GET ALL
        @posts = Post.all
        render json: @posts
        # [END] GET ALL
      end
    end

    # GET /posts/1
    def show
      render json: @post
    end

    # POST /posts
    def create
      @post = Post.new(post_params)

      if @post.save
        render json: @post
      else
        render json: { error: "Errors while posting" }
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: { error: "Errors while posting" }
      end
    end

    # DELETE /posts/1
    def destroy
      @post.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name, :imageUrl, :directions, :ingredients, :user_id)
    end
  end
end
