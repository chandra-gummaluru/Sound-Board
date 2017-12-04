module Outputter(input clock, input en, input[5:0] soundIn, input[5:0] soundOut);
	always @ (posedge clock) begin
		if (en)
			soundOutReg = soundIn;
		else
			soundOutReg = 6'b0;
	end
	
	assign soundOut = soundOutReg;
endmodule