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
    @user = widget_user
  end
end
