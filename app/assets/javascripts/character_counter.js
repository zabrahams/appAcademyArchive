var ready;
ready = function() {
	$("#micropost_content").on("keyup", function() {
    var char_count = $(this).val().length;
    var chars_left = char_count > 140 ? 0 : 140 - char_count
    var char_plural = chars_left != 1 ? " Characters Remaining" : " Character Remaining"
    $("#character_count").text(chars_left + char_plural);
})};

$(document).ready(ready);
$(document).on('page:load', ready);