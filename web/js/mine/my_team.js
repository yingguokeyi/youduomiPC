$(function(){
	$(".bot_ul li").click(function() {
		$(this).children("a").addClass("tabhover").parent().siblings().find("a").removeClass("tabhover");
		
	})
})