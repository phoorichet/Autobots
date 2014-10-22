require 'csv'
puts "=== Loading File ==="

APP_FILE_DIRECTORY = "./data/export/youtube.csv"
APP = "youtube"
MODEL = RawYoutube

puts " => #{APP}"
Dir.glob(APP_FILE_DIRECTORY) do |file|
  puts "reading... #{file}"
  count_record = 0
  needed_attributes = ["imei", "imsi", "script_name", "operator", "technology", "avg_rssi", "avg_rxlen", "avg_ecio", "cell_id", "lac", "start_time", "stop_time", "duration_time", "data_download_transfer", "throughput_download_app", "throughput_download_rlc", "result", "result_detail", "youtube_video_duration", "lat", "lon", "apn"]


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
      start_date = DateTime.strptime(record[:start_time], '%d-%b-%y %H.%M.%S.%N %p')
      start_date = start_date.new_offset(7.0/24) # Modify to local time zone

      stop_date = DateTime.strptime(record[:stop_time], '%d-%b-%y %H.%M.%S.%N %p')
      stop_date = start_date.new_offset(7.0/24) # Modify to local time zone

      record[:start_time] = start_date
      record[:stop_time] = stop_date

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
