module main(X, Clock, Resetn, Enter, Change, LEDS);
input Clock, Resetn, Enter, Change;
input [3:0] X;
wire Alarm, New, Open;
output [0:6] LEDS;
wire isCorrect, enter_pulse, change_pulse;
wire [2:0] out;
wire [3:0] combination;

register4 reg4(X, Clock, Resetn, New, combination);
comparator compare(X, combination, isCorrect);

pulseCircuit ePulse(Clock, Enter, enter_pulse);
pulseCircuit cPulse(Clock, Change, change_pulse);

Combination_Lock combo(Clock, Resetn, enter_pulse, change_pulse, Alarm, New, Open, isCorrect);

assign out[2] = Alarm;
assign out[1] = New;
assign out[0] = Open;

hexDisp seg7(out, LEDS);
endmodule