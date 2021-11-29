module Api
  class FavoritesController < ApplicationController
    before_action :set_favorite, only: [:show, :update, :destroy]

    # GET /favorites
    def index
      if params[:thisaction].present?
        # [START] COUNT ALL POST BY USER'S OR POST'S ID
        if params[:thisaction] == "countFavsByUserId"
          @result = Favorite.where("user_id = ?", params[:user_id]).count
          render json: { postNumber: @result }
        end
        if params[:thisaction] == "countFavsByPostId"
          @result = Favorite.where("post_id = ?", params[:post_id]).count
          render json: { postNumber: @result }
        end
        # [END] COUNT BY ID USER'S OR POST'S ID
        # [START] GET ALL POST BY USER'S OR POST'S ID
        if params[:thisaction] == "getFavsByUserId"
          @result = Favorite.where("user_id = ?", params[:user_id])
          render json: @result
        end
        if params[:thisaction] == "getFavsByPostId"
          @result = Favorite.where("post_id = ?", params[:post_id])
          render json: @result
        end
        # [END] COUNT BY ID USER'S OR POST'S ID
        # [START] GET A RECORD BY 2 PARAMS
        if params[:thisaction] == "getByUserIdAndPostId"
          @result = Favorite.where("post_id = ? AND user_id = ?", params[:post_id], params[:user_id])
          render json: @result
        end
        # [END] GET A RECORD BY 2 PARAMS
      else
        @favorites = Favorite.all
        render json: @favorites
      end
    end

    # GET /favorites/1
    def show
      render json: @favorite
    end

    # POST /favorites
    def create
      @favorite = Favorite.new(favorite_params)
      if @favorite.save
        render json: @favorite
      else
        render json: @favorite.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /favorites/1
    def update
      if @favorite.update(favorite_params)
        render json: @favorite
      else
        render json: @favorite.errors, status: :unprocessable_entity
      end
    end

    # DELETE /favorites/1
    def destroy
      if @favorite.destroy
        render json: { message: "success" }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_params
      params.require(:favorite).permit(:user_id, :post_id)
    end
  end
end
