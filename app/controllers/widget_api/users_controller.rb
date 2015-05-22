class WidgetApi::UsersController < WidgetController
  before_action :set_user

  def show
  end

  def update
    @user.name = params[:user][:name]
    @user.save!
  end

  private

  def set_user
    @user = current_user
  end
end
