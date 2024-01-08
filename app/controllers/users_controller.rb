class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create new]
  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users 
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :salt, :name)
    end
end
