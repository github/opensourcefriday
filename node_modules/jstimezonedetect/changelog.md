# September 9th 2019

* America/Caracas changed from -4.30 hours year round to straight -4 hours, year round. No DST. 
  This change happened in May of 2016. So this is comparable to Atlantic Standard Time.
  America/Santo_Domingo will henceforth be returned for America/Caracas - removed America/Caracas
  from tests.
* Africa/Casablanca has up to 6 daylight savings time during a year, because Ramadan. This has caused
  the addition of the `60,1,weird` lookup key (needle)
* Africa/Windhoek no longer observes Daylight Savings time (But since 2014 is our base year, Windhoek is
now added to ambiguities for Beirut)
* Pacific/Norfolk abandoned the 11.30 offset for straight 11 in 2015. Removing from tests, but keeping
a key for it. Cuz you never know. However, Pacific/Nouema should normally be returned for this tz.