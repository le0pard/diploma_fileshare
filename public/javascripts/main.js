elementSupportsAttribute=function(a,b){var c=document.createElement(a);if(b in c){return true;}else{return false;}};$(document).ready(function(){if($("#s").length>0){$("#s").bind("focus",function(){if($(this).attr("rel")==$(this).val()){$(this).val("").css("color","#000");}});$("#s").bind("blur",function(){if($(this).val()==""){$(this).val($(this).attr("rel")).css("color","#CCC");}});}});