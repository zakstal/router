class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(param_stuff)
    if @user.save
      render json: @user
    else
      render(
        json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])
    @user.update(param_stuff)
    render json: @user
  end

  def destroy
    @user = User.delete(param_stuff[:id])
    render json: @user
  end

  private
  def param_stuff
    params.require(:user).permit(:name, :email)
  end

end

