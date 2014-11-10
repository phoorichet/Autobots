require "locke/config/mixin"
require "locke/dsl/qdsl"

class RawSpeedtest < ActiveRecord::Base
  include Locke::Config::Mixin
  include Locke::Dsl::Qdsl

  set_default :export_attr, [:techology, :datetime, :download, :upload, :latency,
                             :server_id, :server_name, :avg_ecio, :avg_rssi, 
                             :mcc, :mnc, :lac, :cell_id, :result, :operator,
                             :set_server_id, :set_server_name, :apn, 
                            ]
end
