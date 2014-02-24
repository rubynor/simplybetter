module ApplicationHelper
  def set_error_class(model_object, field)
    'has-error' if model_object.errors.messages[field]
  end

  def active(app)
    if app.name == @application.name
      'active'
    end
  end
end
