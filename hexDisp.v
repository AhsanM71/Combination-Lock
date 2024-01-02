module hexDisp (in,leds);
//===== INPUT OUTPUT DECLARATIONS =====//
input [2:0]in;
output reg [0:6]leds;

//===== BEHAVIOURAL FLOW MODEL =====//
always @(in)
	case(in)
		0: leds = 7'b1111110; // LOW for all
		1: leds = 7'b0000001; // Open
		2: leds = 7'b1101010; // NEW
		4: leds = 7'b0001000; // Alarm
	default: leds = 7'b0000000;
	endcase
endmodule