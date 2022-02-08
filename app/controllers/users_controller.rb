class UsersController < ApplicationController

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: 201
        else 
            render json: { error: user.errors.full_messages }, status: 422
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, status: 200
        else
            render json: { error: "Invalid credentials"}, status: 401
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
