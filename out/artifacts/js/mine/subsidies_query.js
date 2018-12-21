$(function(){
	$('#cl_sel').click(function(){
		$('#year_sel').toggle();
	})
	$('#year_sel ul li').click(function(){
		$('.year').html($(this).html());
	})
	$('#cli_sel').click(function(){
		$('#mont_sel').toggle();
	})
	$('#mont_sel ul li').click(function(){
		$('.month').html($(this).html());
	})
	
})