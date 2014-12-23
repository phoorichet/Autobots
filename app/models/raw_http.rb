require "locke/config/mixin"
require "locke/dsl/qdsl"

class RawHttp < ActiveRecord::Base
  include Locke::Config::Mixin
  include Locke::Dsl::Qdsl

  #(id: integer, connecting_time_1: float, time_to_first_byte_1: float, result_1: string, 
  # result_detail_1: string, imei: string, imsi: string, script_name: string,
  # service: string, service_info: string, avg_rssi: float, avg_rxlev: float, 
  # avg_ecio: float, cell_id: integer, lac: integer, start_time: datetime, 
  # stop_time: datetime, duration_time: float, data_download_transfer: integer, 
  # max_download: float, max_download_overall: float, min_download: float, 
  # throughput_download_ip: float, throughput_download_app: float, 
  # throughput_download_rlc: float, result: string, lat: float, lon: float, 
  # apn: string, created_at: datetime, updated_at: datetime
  # Tell the front-end which attributes are measurable
  set_default :export_attr, [:connecting_time_1, :time_to_first_byte_1, :avg_rssi,
                            :avg_rxlev, :avg_ecio, :duration_time, 
                            :data_download_transfer, :max_download_overall,
                            :min_download, :throughput_download_ip, :throughput_download_app,
                            :throughput_download_rlc, :result]

  # make_column :http_succ_rate, -> { }
  # 
  
  scope :facebook,  -> { where("script_name LIKE ?", "%facebook%") }
  scope :instagram, -> { where("script_name LIKE ?", "%Instagram%") }
  scope :twitter,   -> { where("script_name LIKE ?", "%Twitter%") }

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
