require "locke/config/mixin"
require "locke/dsl/qdsl"

class RawPing < ActiveRecord::Base
  include Locke::Config::Mixin
  include Locke::Dsl::Qdsl

  #RawPing(id: integer, imei: string, imsi: string, technology: string, 
  #datetime: datetime, packet_sent: integer, packet_received: integer, 
  #packet_lost: integer, rtt_min: float, rtt_max: float, rtt_mdev: float, 
  #apn: string, apn_mcc: integer, apn_mnc: integer, ip: string, lac: integer, 
  #cell_id: integer, script_name: string, packet_size: integer, created_at: 
  #datetime, updated_at: datetime)
  
  set_default :export_attr, [:packet_sent, :packet_received, :packet_lost, 
                            :rtt_min, :rtt_max, :rtt_mdev, :packet_size,
                            :imei, :imsi, :technology, :datetime, :apn,
                            :apn_mcc, :apn_mcc, :ip, :lac, :cell_id, :script_name,
                            :packet_size, :percent_loss
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
