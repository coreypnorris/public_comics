jQuery(function() {
  return $('#search').autocomplete({
    source: $('#search').data('autocomplete-source')
  });
});
