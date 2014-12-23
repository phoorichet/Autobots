require "locke/config/mixin"
require "locke/dsl/qdsl"

class RawYoutube < ActiveRecord::Base
  include Locke::Config::Mixin
  include Locke::Dsl::Qdsl

  set_default :export_attr, [:imei, :imsi, :script_name, :operator, :technology,
                             :avg_rssi, :avg_rxlev, :avg_ecio, :cell_id, :lac,
                             :start_date, :stop_date, :duration_time,
                             :data_download_transfer, :throughput_download_app,
                             :throughput_download_rlc, :result, :result_detail,
                             :youtube_video_duration, :lat, :lon, :apn, 
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
