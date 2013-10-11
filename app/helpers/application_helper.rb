module ApplicationHelper

  def set_error_class(model_object, field)
    'has-error' if model_object.errors.messages[field]
  end
end
