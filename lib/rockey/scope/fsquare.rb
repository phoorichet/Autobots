require 'active_support/concern'

module Rockey::Scope::Fsquare
  extend ActiveSupport::Concern

  attr_accessor :config

  included do
    init
  end

  # This inner module is defined for class method
  module ClassMethods

    attr_accessor :config    # Class configurations
    
    def init
      @config = Hash.new
    end

    def show_config
      @config
    end

    def xaxis(xaxis)
      axis = xaxis.is_a?(String) ? xaxis : xaxis.to_s
      raise "Attribute '#{xaxis}' could not be found!" if not self.attribute_names.include?(axis)
      @config[:xaxis] = axis
    end

    def yaxis(yaxis)
      axis = yaxis.is_a?(String) ? yaxis : yaxis.to_s
      raise "Attribute '#{yaxis}' could not be found!" if not self.attribute_names.include?(axis)
      @config[:yaxis] = axis
    end

    def stack(attribute)
      @config[:group] ||= Array.new
      
    end

    # Prepare for line chart
    def line
      @config[:type] = :line
    end

    def from(timestamp)
      where("date_time >= ?", timestamp)
    end

    def to
            
    end

    def stop
      
    end
    
  end 

end