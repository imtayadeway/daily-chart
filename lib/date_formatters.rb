module DateFormatters
  def weekday
    date.strftime("%a")
  end

  def day
    date.day
  end
end
