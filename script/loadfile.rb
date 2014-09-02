require 'csv'
puts "=== Loading File ==="

APP_FILE_DIRECTORY = "./data/precal_speedtest.csv"
APP = "speedtest"
puts " => #{APP}"
Dir.glob(APP_FILE_DIRECTORY) do |file|
  puts "reading... #{file}"
  count_record = 0
  # Read csv file
  CSV.foreach(file, { :headers => true, :header_converters => :symbol, :converters => :all, :col_sep =>",", :encoding =>"ISO8859-11" }) do |row|
    # puts row
    begin
      record = row.to_hash
      record.delete(:trans_date)
      # date = DateTime.strptime(record[:date_time], '%m/%d/%Y %H:%M:%S')
      date = DateTime.strptime(record[:date_time], '%m/%d/%y %H:%M')
      date = date.new_offset(7.0/24) # Modify to local time zone
      record[:created_at] = date
      record[:date_time] = date
      # puts record
      MetricSpeedtest.new(record).save

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
