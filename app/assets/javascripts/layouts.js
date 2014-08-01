// Autocomplete for title name navbar search field
jQuery(function() {
  return $('#search').autocomplete({
    source: $('#search').data('autocomplete-source')
  });
});
