module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :success
      "alert-success"
    when :notice
      "alert-info"
    when :alert
      "alert-warning"
    when :danger
      "alert-danger"
    else
      flash_type.to_s
    end
  end
end
