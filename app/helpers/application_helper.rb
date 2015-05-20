module ApplicationHelper
  def set_error_class(model_object, field)
    'has-error' if model_object.errors.messages[field]
  end

  def active(app)
    'active' if app.id == @application.id
  end
end
