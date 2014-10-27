module ApplicationHelper
  def fix_url(str)
    str.start_with?("http://") ? str : "http://#{str}"
  end
  
  def date_time(dt)
    dt.strftime('%d/%m/%Y %I:%M %P IST')
  end
  
end
