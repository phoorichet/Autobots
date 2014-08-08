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


  module ApiClassMethod
  end

end
