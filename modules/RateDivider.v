module RateDivider(input reset, clk, input[27:0] rate, output out);

	reg[10:0] counter;
	initial counter = 11'b0;
	
	always @(posedge clk) begin
	 
		//active high reset OR counter equal zero => reset counter to rate
		if (reset || !counter)
			counter <= rate;
		else
			counter <= counter - 1'b1;
	
	end
	
	//output '1' when counter equals 0... after 'rate' clk posedges
	assign out = !counter;
	
endmodule