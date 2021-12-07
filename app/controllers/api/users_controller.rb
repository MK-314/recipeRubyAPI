module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    def index
      if params[:thisaction].present?
        # [START] FIND BY EMAIL
        if params[:thisaction] == "getByEmail"
          @user = User.where("email = ?", params[:email])
          render json: @user
        end
        # [END] FIND BY EMAIL
      else
        # [START] GET ALL
        @users = User.all
        render json: @users
        # [END] GET ALL
      end
    end

    # GET /users/1
    def show
      if params[:thisaction].present?
        if params[:thisaction] == "getFollowers"
          @result = User.find_by_sql(["SELECT * FROM users
            WHERE id in 
            (SELECT DISTINCT user_id FROM (
            SELECT 
            favorites.user_id,
            favorites.post_id,
            posts.name,
            posts.directions,
            posts.ingredients,
            posts.imageUrl,
            posts.user_id AS post_user_id,
            posts.likes
            from favorites
            INNER JOIN posts ON posts.id = favorites.post_id
            WHERE posts.user_id = ?) AS user_id)", params[:id]])
          render json: @result
        end
      else
        render json: @user
      end
    end

    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      @user.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :avatar)
    end
  end
end
