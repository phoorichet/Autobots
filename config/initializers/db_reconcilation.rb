Rails.application.config.after_initialize do
  # initialization code goes here
  
  
  # Change the database configuration for production environment
  if ENV["RAILS_ENV"] == 'production'
    puts "---> Changing database configuration for production.."
    RawHttp.table_name      = 'RAWROBOT.DATASESSION'
    RawPing.table_name      = 'RAWROBOT.PINGSESSION'
    RawSpeedtest.table_name = 'RAWROBOT.SPEEDTESTSESSION'
    RawYoutube.table_name   = 'RAWROBOT.YOUTUBE'
    MsLocation.table_name   = 'RAWROBOT.MS_LOCATION'
    MsRncSgsn.table_name    = 'RAWROBOT.MS_RNC_SGSN'
    puts "---> Finished.."
  end
end