module ApiHelper

  # This method is called when someone does 'include Wms::Config::Mixin'
  def self.included(base)
    # Add all methods in MixinClassMethod as Class method.
    # When Mixin is included, the user can call:
    # => Mixin.list_mixins
    base.extend(ApiHelper::ApiClassMethod)
  end

  def validate_params(params)
    return true
  end


  def valid_params?(params, options = {})
    valid_flag = true
    options.each do |k,v|
      if not params[k].is_a? v
        valid_flag = false
      end
    end
    return valid_flag
  end

  # Convert long to date object
  def long_to_date(timeat)
    Time.at(timeat / 1000, timeat % 1000)
  end

  # A block return a rage of time from 'start' to 'stop.'
  # It is incrementally added by 'step.'
  # Step is in millisecond
  def start_to_stop(start, stop, step, &block)
    _start = start
    _stop  = stop
    if step == nil or step <= 0
      raise "Params error: step must be greater than 0"
    end
    while _start < _stop
      _next_start = _start.advance(:seconds => step / 1000, :milliseconds => step % 1000)
      block.call(_start, _next_start)
      _start = _next_start
    end
  end

  # Parse the params to get all required options.
  def build_options(params)
    timeobj = JSON.parse(params[:time])
    vspec   = params[:vspec] != nil ? JSON.parse(params[:vspec]) : nil
    start   = long_to_date(timeobj["from"]["time"])
    stop    = long_to_date(timeobj["to"]["time"])

    where = []

    if not timeobj.empty?
      # where << "date_time >= '#{start}'"
      # where << "date_time >= '#{stop}'" 
    end

    group       = "'g'"
    # stack       = params[:stack]
    return {
        :metric_attr => params[:attr],
        :timeobj     => timeobj,
        :start       => long_to_date(timeobj["from"]["time"]),
        :stop        => long_to_date(timeobj["to"]["time"]),
        :region      => params[:region],
        :site        => params[:site],
        :apn         => params[:apn],
        :stack       => params[:stack],
        :sgsn        => params[:sgsn],
        :function    => "avg", # Fixed for now
        :group       => group,
        :vspec       => vspec,
        :criteria    => where
      }
  end

  # Create a string for SELECT cause with hash params.
  def build_select(params)
      return "date_time, #{params[:group]} as group, #{params[:function]}(#{params[:metric_attr]}) as value"
  end

  # Create a string for group operation
  def build_groups(params)
    group_array = [:date_time]
    group       = "date_time"
    stack       = params[:stack]
    if stack.casecmp("GGSN").zero?
      group_array << :apn
    elsif stack.casecmp("RNC").zero?
      group_array << :rncname
    elsif stack.casecmp("region").zero?
      group_array << :region
    else
      # Do nothing
    end
    return group_array.join(",")
  end


  module ApiClassMethod
  end

end
