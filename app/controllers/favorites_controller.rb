class FavoritesController < ApplicationController
    def index
        @favorites = Favorite.all
        
        render json: @favorites
    end

    def create
        @favorite = Favorite.create(favorite_params)
        render json: @favorite
    end

    def show
        
        render json: @favorite, include: [:jobs, :users]
    end

    def update
        @favorite.update(favorite_params)
        render json: @favorite
    end

    # def destroy
    #     @favorite.destroy
    # end
    private 

    def favorite_params
        params.require(:favorite).permit(:user_id, :job_id, :organization, :title, :done)
    end
end