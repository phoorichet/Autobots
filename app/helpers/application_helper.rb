module ApplicationHelper
  def self.included(base)
    # Add all methods in MixinClassMethod as Class method.
    # When Mixin is included, the user can call:
    # => Mixin.list_mixins
    base.extend(ApplicationHelper::ClassMethods)
  end
  
  module ClassMethods
  end


  # Use to identify the active page
  def is_active(path)
    style_class = "active"  
    current_page?(path) ? style_class : nil        
  end

  # Flash message
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end
 
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
      end)
    end
    nil
  end
end
