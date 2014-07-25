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
end
