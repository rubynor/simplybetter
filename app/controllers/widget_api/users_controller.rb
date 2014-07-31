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

  def set_user
    @user = get_current_user(params[:token], params[:email])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
