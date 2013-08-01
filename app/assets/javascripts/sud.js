
	function check_board(obj, id_num, answer) {
		console.log("in check_board");
		//obj.css("height","200px" );
		//var $(cell) = document.getElementById(obj.id); 

		console.log("obj.id: " + obj.id.toString());
		//var inp = getElementById("obj.id");
		var guess = obj.value;
		if ( guess != answer && guess != "") {
			$("#"+obj.id).css('color', 'red');

			console.log("in not equal part of function");
			console.log("obj.value: " + obj.value);

			console.log("obj.attr(id): " + obj.id);
		} 
		else if (guess == answer) {
			console.log("correct. obj.value: " + guess);
			$("#"+obj.id).css("color", "green");
		}
	}


jQuery(document).on('click', '#submit_board', function() {
	check_final();
});

function check_final() {
	var guess = "";
	var answer = $('#submit_board').attr('ans');
	for(var i=0; i<81; i++) {
		guess += $('#td_' + i).val();
	}
	console.log("guess: " + guess);
	console.log("answer: " + answer);
	if(guess == answer){
		correct_answer();
	}
	else {
		incorrect_answer();
	}
}

function correct_answer() {
	$('#board_heading').before('Solution found.').fadeIn('slow');
}

function incorrect_answer() {
	$('#board_heading').before('Solution incorrect.');
}

jQuery(document).on('click', '#show_sol', function() {
	toggle_solution();
});

function toggle_solution() {
	$('#sol_div').toggleClass('hide');
}

jQuery(document).on('click', '#debug_btn', function() {
	show_debug();
});

function show_debug() {
	$('#debug_info').toggleClass('hide');
}
