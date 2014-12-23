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

  def get_site
    if (self.apn.index("CWD"))
      return "CWD"
    elsif (self.apn.index("TLS"))
      return "TLS"
    elsif (self.apn.index("SUK"))
      return "SUK"
    else
      return "Unknow"
    end  
  end

  def get_vendor
    length = self.apn.length
    return self.apn[length-1..length]
  end
end
