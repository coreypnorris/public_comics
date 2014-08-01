// Autocomplete for title name in new issue form
jQuery(function() {
  return $('#issue_title_name').autocomplete({
    source: $('#issue_title_name').data('autocomplete-source')
  });
});
