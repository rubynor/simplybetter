class WidgetApi::UsersController < ApplicationController
  include CreatorFinder
  before_action :set_user

  def show
  end

  def update
    @user.name = user_params[:name]
    @user.save!
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end

  def application_params
    params.require(:application).permit(:token)
  end

  def set_user
    @user = get_current_user(application_params[:token], user_params[:email])
  end
end
