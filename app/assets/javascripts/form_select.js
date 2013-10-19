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

  $("a#enable_coupon").click(function() {
    $("#coupon_field").removeClass("hidden");
    $("#coupon_field input").prop("disabled", false).focus();
    $(this).hide();
    return false;
  });
}

$(document).ready(do_on_load);
$(window).bind('page:change', do_on_load);
