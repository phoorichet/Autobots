Rails.application.config.after_initialize do
  # initialization code goes here
  
  
  # Change the database configuration for production environment
  if ENV["RAILS_ENV"] == 'production'
    puts "---> Changing database configuration for production.."
    RawHttp.table_name = 'RAWROBOT.DATASESSION'
    # RawHttp.set_datetime_column :start_time
    # 
    puts "---> Finished.."
  end
end