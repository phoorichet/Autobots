require 'csv'
puts "=== Loading File ==="

APP_FILE_DIRECTORY = "./data/SpeedTest-SPEEDTEST-21-07-2014.csv"
APP = "Speedtest"
puts " => #{APP}"
Dir.glob(APP_FILE_DIRECTORY) do |file|
  puts "reading... #{file}"
  count_record = 0
  # Read csv file
  # Ex.
  CSV.foreach(file, { :headers => true, :header_converters => :symbol, :converters => :all, :col_sep =>",", :encoding =>"ISO8859-11" }) do |row|
    # puts row
    begin
      record = row.to_hash
      date = DateTime.strptime(record[:date_time], '%m/%d/%Y %H:%M:%S')
      record[:created_at] = date
      record.delete(:date_time)
      puts record
    rescue
      puts "ERROR: Couldn't convert date_time - #{record}"
    end
    # d = UsageRecord.new(record)
    # d.save
    count_record += 1
    puts "...#{count_record}" #if count_record % 1000 == 0
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
