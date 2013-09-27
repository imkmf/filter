$(document).ready(function() {
  $(".select2").each(function() {
    $(this).select2();
  });

  $(".select3").each(function() {
    $(this).select2({
      placeholder: "Select a category: ",
      maximumSelectionSize: 3,
    });
  });
});
