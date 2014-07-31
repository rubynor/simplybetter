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
    app = Application.find_by(token: params[:token])
    @user = get_current_user(app, params[:email])
  end
end
