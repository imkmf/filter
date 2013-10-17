var do_on_load = function() {
  $(".select2").each(function() {
    $(this).select2();
  });

  $(".select3").each(function() {
    $(this).select2({
      placeholder: "Select a category: ",
      maximumSelectionSize: 3,
    });
  });

  $("#podcast_keywords").tagsInput();
  $("#episode_keywords").tagsInput();
}

$(document).ready(do_on_load);
$(window).bind('page:change', do_on_load);
