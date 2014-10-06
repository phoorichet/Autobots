require "locke/version"

module Locke
  module Config
    autoload :Mixin, 'locke/config/mixin'
  end

  module Scope
    autoload :Dsl, 'locke/dsl/qdsl'
  end
end