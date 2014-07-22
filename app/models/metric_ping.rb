class MetricPing < ActiveRecord::Base
  attr_accessible :region, :location, :rncname, :mobile_code, :imei, :imsi, 
                  :target_ip, :attempt, :percent_loss, :avg_packet_loss_rate, 
                  :avg_rtt_succ_rate
end
