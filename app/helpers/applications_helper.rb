module ApplicationsHelper
  def selected(app, icon)
    "selected" if app.icon == icon
  end
end
