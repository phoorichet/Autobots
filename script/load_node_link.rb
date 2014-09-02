require 'csv'
puts "=== Loading File ==="

APP_FILE_DIRECTORY = "config/viz/nodes.csv"
APP = "Node"
puts "=> #{APP}"
Dir.glob(APP_FILE_DIRECTORY) do |file|
  puts "reading.. #{file}"
  count_record = 0
  # Read csv file
  CSV.foreach(file, { :headers => true, :header_converters => :symbol, :converters => :all, :col_sep =>",", :encoding =>"ISO8859-11" }) do |row|
    # puts row
    begin
      record = row.to_hash
      puts record
      Node.find_or_create_by(record)
    rescue => e
      puts e
      puts row
    end
    # d = UsageRecord.new(record)
    # d.save
    count_record += 1
    puts "...#{count_record}" if count_record % 1000 == 0
  end
end

APP_FILE_DIRECTORY = "config/viz/links.csv"
APP = "Link"
puts "=> #{APP}"
Dir.glob(APP_FILE_DIRECTORY) do |file|
  puts "reading.. #{file}"
  count_record = 0
  # Read csv file
  CSV.foreach(file, { :headers => true, :header_converters => :symbol, :converters => :all, :col_sep =>",", :encoding =>"ISO8859-11" }) do |row|
    # puts row
    begin
      record = row.to_hash
      puts record
      Link.find_or_create_by(record)
    rescue => e
      puts e
      puts row
    end
    # d = UsageRecord.new(record)
    # d.save
    count_record += 1
    puts "...#{count_record}" if count_record % 1000 == 0
  end
end
