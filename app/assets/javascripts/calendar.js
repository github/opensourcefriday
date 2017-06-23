//= require addtocalendar/addtocalendar

document.addEventListener("DOMContentLoaded", function(event) {
  var timezone = jstz.determine();
  if (timezone) {
    timezone_name = timezone.name();
    timezones = document.getElementsByClassName("atc_timezone");
    for (i = 0; i < timezones.length; i++) {
      timezones[i].textContent = timezone_name;
    }
  }
  addtocalendar.load();
});
