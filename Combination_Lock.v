module Combination_Lock(Clock, Resetn, Enter, Change, Alarm, New, Open, isCorrect);
input Clock, Resetn, Enter, Change, isCorrect;
output Alarm, New, Open;
reg [2:0] y, Y;

parameter initial_stage = 3'b000, attempt1 = 3'b001, attempt2 = 3'b010, match = 3'b011, change_combo = 3'b100;

// Define the next state combinational circuit
always @(y, Enter, Change, isCorrect)
begin
	case (y)
		initial_stage: if (isCorrect == 1 && Enter == 1) Y = match;
							else if ((Enter == 1 || Change == 1) && isCorrect == 0) Y = attempt1;
							else if (isCorrect == 1 && Change == 1) Y = change_combo;
							else Y = initial_stage;
							
		attempt1: 		if (isCorrect == 1 && Enter == 1) Y = match;
							else if (isCorrect == 1 && Change == 1) Y = change_combo;
							else if ((Enter == 1 || Change == 1) && isCorrect == 0) Y = attempt2;
							else Y = attempt1;
							
		attempt2: Y = attempt2;
		
		match: 			if (Enter == 1) Y = initial_stage;
							else Y = match;
							
		change_combo:  if (Enter == 1 || Change == 1) Y = initial_stage;
							else Y = change_combo;
		default: Y = 3'bxxx;	
	endcase
end
// Define the sequential block
always @(posedge Clock, negedge Resetn)
begin
	if (Resetn == 0)
		y <= initial_stage;
	else
		y <= Y;
end

	assign Alarm = (y == attempt2);
	assign New = (y == change_combo);
	assign Open = (y == match);

endmodule