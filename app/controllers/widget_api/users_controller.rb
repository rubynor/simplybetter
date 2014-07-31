class WidgetApi::UsersController < ApplicationController
  include CreatorFinder
  before_action :set_user

  def show
  end

  def update
    @user.name = params[:name]
    @user.save!
  end

  private

  def set_user
    @user = get_current_user(params[:token], params[:email])
  end
end
