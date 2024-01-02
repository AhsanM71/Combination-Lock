module comparator(inputX, combo, out);
input [3:0] inputX, combo;
output reg out;

always @(inputX, combo)
begin
	if (inputX == combo)
		out = 1;
	else
		out = 0;
end
endmodule