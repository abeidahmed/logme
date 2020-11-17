module DateTimeHelper
  def format_date(date_time, long: false)
    if long
      date_time.strftime("#{date_time.day.ordinalize} %B %Y")
    else
      date_time.strftime("#{date_time.day.ordinalize} %b, %Y")
    end
  end
end