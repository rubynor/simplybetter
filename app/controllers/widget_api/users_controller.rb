class WidgetApi::UsersController < ApplicationController
  include DecodeParams
  include CreatorFinder
  before_action :set_user

  def show
  end

  def update
    @user.name = params[:user][:name]
    @user.save!
  end

  private

  def set_user
    app = Application.find_by(token: params[:appkey])
    @user = get_current_user(app, params[:email])
  end
end
