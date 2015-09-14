module ApplicationHelper
  def set_error_class(model_object, field)
    'has-error' if model_object.errors.messages[field]
  end

  def active(app)
    return unless @application
    'active' if app.id == @application.id
  end

  def percent_of_total(total, selection)
    "#{number_with_precision( (selection.to_f / total.to_f) * 100, precision: 0 )}%"
  end
end
