class UsersController < ApplicationController

    before_action :find_user, only: [:show, :update]

    def index
        @users = User.all
        render json: @users
    end

    def profile
        render json: current_user, include: [:favorites, :jobs]
    end
    
    def create
        user = User.create(user_params)

        if user.valid?
            render json: {token: encode_token(user.id)}
        else
            render json: {errors: user.errors.full_messages}, status: 422
        end
    end

    def show
        render json: @user, include: [:jobs, :favorites]
    end

    def update
        @user.update(user_params)
        render json: @user
    end

    private

    def user_params
        params.permit(:username, :password, :points, :monthly_goal, :admin)
    end

    def find_user
        @user = User.find(params[:id])
    end

end
