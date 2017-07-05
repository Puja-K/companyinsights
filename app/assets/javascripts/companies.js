

jQuery(function() {
  return $('#search_company').autocomplete({
    source: $('#search_company').data('autocomplete-source')
  });
});