require 'active_support/concern'
require 'locke/dsl/query'

module Locke::Dsl::Qdsl
  extend ActiveSupport::Concern

  attr_accessor :config

  included do
    init
  end

  class Query
    attr_accessor :criteria, :where, :model, :type

    DEFAULT_INTERVAL = {minutes: -15}

    def initialize(model)
      @model      = model
    end

    def where(value)
      @where ||= []
      @where << value

      self
    end

    def vtype(type)
      @type = type

      self
    end

    def xaxis(xaxis)
      axis = xaxis.is_a?(String) ? xaxis : xaxis.to_s
      raise "Attribute '#{xaxis}' could not be found!" if not self.model.attribute_names.include?(axis)
      @criteria ||= Hash.new
      @criteria[:xaxis] = axis

      self
    end

    def yaxis(yaxis)
      axis = yaxis.is_a?(String) ? yaxis : yaxis.to_s
      raise "Attribute '#{yaxis}' could not be found!" if not self.model.attribute_names.include?(axis)
      @criteria ||= Hash.new
      @criteria[:yaxis] = axis

      self
    end

    def from(value)
      @criteria ||= Hash.new
      @criteria[:from] = value

      self
    end

    def to(value)
      @criteria ||= Hash.new
      @criteria[:to] = value

      self
    end

    def stack(value)
      @criteria ||= Hash.new
      @criteria[:stack] = value if not value.empty?

      self
    end

    def bucket(value)
      @criteria ||= Hash.new
      @criteria[:bucket] = value

      self
    end

    def aggregate(function)
      @criteria ||= Hash.new
      @criteria[:aggregate] = function

      self
    end

    def order(value)
      @criteria ||= Hash.new
      @criteria[:order] = value

      self
    end    

    def validate
      true
    end

    def run
      raise "Error: criteria is not valid!" if not self.validate

      select_array = []
      select_array << "#{@criteria[:xaxis].to_s} as x"
      select_array << " #{@criteria[:stack].to_s} as stack" if @criteria[:stack]
      if not @criteria[:aggregate].to_s.empty?  
        select_array << " #{@criteria[:aggregate].to_s}(#{@criteria[:yaxis].to_s}) as y"
      else
        select_array << " #{@criteria[:yaxis].to_s} as y"
      end

      select_stm = select_array.join(",")
      puts "==> #{@criteria[:aggregate].to_s.empty?}"

      group_array = []
      group_array << @criteria[:xaxis].to_s
      group_array << " #{@criteria[:stack].to_s}" if @criteria[:stack]

      group_stm = group_array.join(',')

      order_stm = "#{@criteria[:order]}"

      @model.select(select_stm)
            .group(group_stm)
            .order(order_stm)
            # .where(where_stm)
            # .where("#{@criteria[:xaxis]} >= ?", @criteria[:from] || DateTime.now)
            # .where("#{@criteria[:xaxis]} < ?", @criteria[:to] || DateTime.now.advance(DEFAULT_INTERVAL))
            

    end

  end


  # This inner module is defined for class method
  module ClassMethods 
    attr_accessor :config
    
    def init
      @config = Hash.new
      
    end

    def show_config
      @config
    end

    def xaxis(axis)
      Query.new(self).xaxis(axis)
    end

    def yaxis(axis)
      Query.new(self).yaxis(axis)
    end

    def vtype(value)
      @config[:vtype] = value
      Query.new(self).vtype(@config)
    end

    def from(value)
      @config[:from] = value
      Query.new(self).from(@config)
    end

    def to(value)
      @config[:to] = value
      Query.new(self).to(@config)  
    end

    def stack(value)
      @config[:stack] = value
      Query.new(self).stack(@config)
    end

    def aggregate(value)
      @config[:aggregate] = value
      Query.new(self).aggregate(@config)  
    end

    def bucket(value)
      @config[:bucket] = value
      Query.new(self).bucket(@config)  
    end    

    def order(value)
      @config[:order] = value
      Query.new(self).order(@config)  
    end    


    
  end 

end