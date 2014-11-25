module ApplicationHelper
  def fix_url(str)
    str.start_with?("http://") ? str : "http://#{str}"
  end
  
  def date_time(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    dt.strftime('%d/%m/%Y %I:%M %P %Z')
  end
  
end

# %Z set's the default time in application.rb file
# to change default time change the aplication.rb file to a different default
