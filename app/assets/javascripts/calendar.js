//= require addtocalendar/addtocalendar

$(document).ready(function() {
  var tz = jstz.determine();
  if (tz) {
    $('.atc_timezone').text(tz.name());
  }
  addtocalendar.load();
});
