module Addresser(input clock, input[14:0] ad0, ad1, ad2, ad3, input en0, en1, en2, en3, output[14:0] adOut, output en);
	
	reg[14:0] adRegOut;
	
	always @ (posedge clock) begin
		if (en0)
			adRegOut = ad0;
		else if (en1)
			adRegOut = ad1;
		else if (en2)
			adRegOut = ad2;
		else if (en3)
			adRegOut = ad3;
		else
			adRegOut = ad0;
	end
	
	assign adOut = adRegOut;
	assign en = en0 | en1 | en2 | en3;
endmodule