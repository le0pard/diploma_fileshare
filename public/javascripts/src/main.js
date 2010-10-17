
elementSupportsAttribute = function(element,attribute) {
  var test = document.createElement(element);
  if (attribute in test) {
    return true;
  } else {
    return false;
  }
}

$(document).ready(function() {
  if (!elementSupportsAttribute('input','placeholder')) {
    if ($("#s").length > 0){
      $("#s").bind('focus', function(){
        if ($(this).attr('rel') == $(this).val()) $(this).val("").css("color", "#000");
      });
      $("#s").bind('blur', function(){
        if ($(this).val() == "") $(this).val($(this).attr('rel')).css("color", "#CCC");
      });
      if ($("#s").val() == ""){
        $(this).val($(this).attr('rel')).css("color", "#CCC");
      }
    }
  }
});