require 'csv'
puts "=== Loading File ==="

APP_FILE_DIRECTORY = "./data/SpeedTest*.txt"
APP = "Speedtest"
puts " => #{APP}"
Dir.glob(APP_FILE_DIRECTORY) do |file|
  puts "reading... #{file}"
  count_record = 0
  # Read csv file
  # Ex.
  # {:date=>"2014/05/01 17:00:00", :msisdn=>66818911698, :imsi=>520038600108793, :application=>"Facebook", :server_setup_time_n=>4025, :server_setup_time_d=>129, :client_setup_time_n=>29355, :client_setup_time_d=>129, :ttfb_n=>0, :ttfb_d=>0, :download_time_ms_n=>303282, :download_time_ms_d=>129, :new_tcp_connection_count=>237}
  CSV.foreach(file, { :headers => true, :header_converters => :symbol, :converters => :all, :col_sep =>"\t", :encoding =>"UTF-16LE" }) do |row|
    # puts row
    record = row.to_hash
    begin
      date = DateTime.strptime(record[:date_time][0..-6], '%m/%d/%Y %H:%M:%S')
      record[:created_at] = date
      record.delete(:date_time)
      # puts record
    rescue
      puts "ERROR: Couldn't convert date_time - #{record}"
    end
    # d = UsageRecord.new(record)
    # d.save
    count_record += 1
    puts "...#{count_record}" if count_record % 1000 == 0
  end
  # sync = SyncInfo.where("application = ?", FB)[0]
  # if sync 
  #   # Update sync info record
  #   sync.status = "successful"
  #   sync.filename = file
  #   sync.last_record = count_record
  # else
  #   # Create a new sync info is not existing
  #   SyncInfo.create({ filename: file, status: "successful", last_record: count_record, application: FB })
  # end

  break
end
