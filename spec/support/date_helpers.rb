def next_weekday_from_today
  date = Date.tomorrow
  while date.saturday? || date.sunday?
    date = date.next_day
  end
  date
end

def next_weekend_from_today
  date = Date.tomorrow
  date += 1.day until date.saturday? || date.sunday?
  date
end