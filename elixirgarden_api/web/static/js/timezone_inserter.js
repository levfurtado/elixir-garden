export var TzInserter = {
  insertTz: function(){
    let current_url = window.location.href
    if( current_url.match(/\/schedules\/[0-9]\/edit/) != null || current_url.match(/\/schedules\/new/) ) {
      $(document).ready( function(){
        offset = new Date().getTimezoneOffset();
        $("#schedule_timezone_offset").val(offset);
      });
    }
  }
}
