//jQuery(function() {
  //return $('#report_to').autocomplete({
   // source: $('#report_to').data('autocomplete-source')
  //});
//});

$(document).ready(function(){

  
// Configure the autocomplete.
  $('.position_autocomplete').autocomplete({
    source: $('.position_autocomplete').data('autocomplete-source'),
   // select: onSelect
  });

  $('#company_name').autocomplete({
    source: $('#company_name').data('autocomplete-source'),
   
  });

  
  // Configure the autocomplete.
  $('#reports_to').autocomplete({
    source: $('#reports_to').data('autocomplete-source'),
    //select: onSelect
  });

  // Invoked when an autocomplete list item is clicked.
  function onSelect(e, ui) {
    setYouReportTo(ui.item.value)
  }

  // Set the specified value on the volume field.
  function setYouReportTo(volume){
    $('#you_report_to').val(volume)
  }
});