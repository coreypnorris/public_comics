// Autocomplete for title name in new issue form
jQuery(function() {
  return $('#title_name').autocomplete({
    source: $('#title_name').data('autocomplete-source')
  });
});

jQuery(function() {
  return $('#title_genre_name').autocomplete({
    source: $('#title_genre_name').data('autocomplete-source')
  });
});
