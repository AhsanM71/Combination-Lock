module testChange(X, Clock, Resetn, Enter, Change, Alarm, New, Open);
input Clock, Resetn, Enter, Change;
input [3:0] X;
output Alarm, New, Open;
wire w;

reg [2:0] y, Y;
reg [3:0] currentCombo = 4'b0110;
reg [3:0] newCombo =  4'b0110;

assign w = (X == currentCombo);

parameter initial_stage = 3'b000, attempt1 = 3'b001, attempt2 = 3'b010, match = 3'b011, change_combo = 3'b100;

// Define the next state combinational circuit
always @(Enter, Change, y, w)
begin
	case (y)
		initial_stage: if (Change == 1 & w == 0) Y = attempt1;
							//else if (Change == 1 & w == 1) Y = change_combo;
							else Y = initial_stage;
		attempt1: if (Change == 1 & w == 0) Y = attempt2;
					//else if (Change == 1 & w == 1) Y = change_combo;
					else Y = attempt1;
		attempt2: Y = attempt2;
		//match: if (Enter == 1) Y = initial_stage;
			//	 else Y = match;
		change_combo: if (Enter == 1 | Change == 1)
						  begin
									newCombo = X;
									Y = initial_stage;
									
									
						  end
						  else Y = change_combo;
		default: Y = 3'bxxx;	
	endcase
end
// Define the sequential block
always @(posedge Clock, negedge Resetn)
begin
	if (Resetn == 0)
	begin
		currentCombo <= 4'b0110;
		y <= initial_stage;
	end
	else
	begin
		y <= Y;
		currentCombo <= newCombo;
	end
// Define output
end
	assign Alarm = (y == attempt2);
	assign New = (y == change_combo);
	//assign Open = (y == match);

endmodule