module pulseCircuit(Clock, A, A_Pulse);
input Clock, A;
output A_Pulse;
reg [2:1] y, Y;
parameter [2:1] initial_node = 2'b00, first_occur = 2'b01, nth_occur = 2'b10;
// Define the next state combinational circuit
always @(A, y)
	case (y)
		initial_node: if (A) Y = first_occur;
						  else 	Y = initial_node;
		first_occur: if (A) 	Y = nth_occur;
						 else 	Y = initial_node;
		nth_occur: if (A) 	Y = nth_occur;
					  else 		Y = initial_node;
		default: Y = 2'bxx;
endcase
// Define the sequential block
always @(posedge Clock)
	y <= Y;
// Define output
assign A_Pulse = (y == first_occur);

endmodule