require 'csv'
puts "=== Loading File ==="

APP_FILE_DIRECTORY = "./data/export/ping.csv"
APP = "ping"
MODEL = RawPing

puts " => #{APP}"
Dir.glob(APP_FILE_DIRECTORY) do |file|
  puts "reading... #{file}"
  count_record = 0
  needed_attributes = ["imei", "imsi", "technology", "datetime", "packet_sent", "packet_received", "packet_lost", "rtt_min", "rtt_max", "rtt_mdev", "apn", "apn_mcc", "apn_mnc", "ip", "lac", "cell_id", "script_name", "packet_size"]

  # Read csv file
  CSV.foreach(file, { :headers => true, :header_converters => :symbol, :converters => :all, :col_sep =>",", :encoding =>"UTF-8" }) do |row|
    # puts row
    begin
      record = row.to_hash
      # puts record
      # Filter out unnessary value in hash
      record = record.select { |k, v| needed_attributes.include? k.to_s }
      # puts record

      # :stop_time=>"10-OCT-14 12.19.17.779000000 AM"
      # # date = DateTime.strptime(record[:date_time], '%m/%d/%Y %H:%M:%S')
      start_date = DateTime.strptime(record[:datetime], '%d-%b-%y %H.%M.%S.%N %p')
      start_date = start_date.new_offset(7.0/24) # Modify to local time zone

      # stop_date = DateTime.strptime(record[:stop_time], '%d-%b-%y %H.%M.%S.%N %p')
      # stop_date = start_date.new_offset(7.0/24) # Modify to local time zone

      record[:datetime] = start_date
      # record[:stop_time] = stop_date

      # puts record
      MODEL.new(record).save

    rescue => e
      puts e
      puts row
    end
    # d = UsageRecord.new(record)
    # d.save
    count_record += 1
    puts "...#{count_record}" if count_record % 1000 == 0
    # break
  end

  break
end
