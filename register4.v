module register4(D, clock, reset, isNewCombo, Q);
//===== INPUT OUTPUT DECLARATIONS =====//
input [3:0] D;
input clock, isNewCombo, reset;
output reg [3:0] Q;

//===== Behavioural FLOW MODEL =====//
always @(posedge clock, negedge reset)
begin
	if (reset == 0)
		Q <= 4'b0110;
	else if (isNewCombo == 1)
		Q <= D;
end
endmodule