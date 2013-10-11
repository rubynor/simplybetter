module ApplicationHelper

  def set_error_class(feature, field)
    'has-error' if feature.errors.messages[field]
  end
end
