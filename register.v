module register(D, Clock, Q);
//===== INPUT OUTPUT DECLARATIONS =====//
input [3:0] D;
input Clock;
output reg [3:0] Q;

//===== Behavioural FLOW MODEL =====//
always @(posedge Clock)
	Q <= D;
	
endmodule