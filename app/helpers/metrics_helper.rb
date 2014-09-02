require 'active_support/concern'

module MetricsHelper
  # extend ActiveSupport::Concern
  # def self.included(base)
  #   # Add all methods in MixinClassMethod as Class method.
  #   # When Mixin is included, the user can call:
  #   # => Mixin.list_mixins
  #   base.extend(ApplicationHelper::ClassMethods)
  # end
  
  # module ClassMethods
  #   attr_accessor :export_attr_list, :export_filter_list

  #   # Export the attributes so that they are allowed to be added, modified
  #   def export_attr(*args)
  #     @export_attr_list ||= []
  #     args.each { |d| if !@export_attr_list.include?(d) then @export_attr_list << d end }
  #   end

  #   def get_export_attr
  #     @export_attr_list
  #   end


  # end
end
