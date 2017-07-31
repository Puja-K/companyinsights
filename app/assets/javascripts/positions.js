

jQuery(function() {
  return $('#search_position').autocomplete({
    source: $('#search_position').data('autocomplete-source')
  });
});