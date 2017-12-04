module ChannelSimulation(input mode, input clear, input playEn, input clock, input[1:0] data, output[1:0] seqOut);
	
	reg [13:0] counter;
	initial counter = 14'b10101100010001;
	
	reg pulse;
	initial pulse = 0;
	
	reg[39:0] seq0, seq1;
	reg[1:0] seqOutHold;
	
	initial seq0 = 40'b1000000010000000100000001000000010000000;
	initial seq1 = 40'b0000100000001000000010000000100000001000;
	
	always @(posedge clock) begin
		
		if (counter > 0) begin
			counter <= counter - 1'b1;
			pulse <= 0;
		end
		else begin
			counter <= 14'b10101100010001;
			pulse <= 1;
		end
	
		if (playEn && pulse) begin
			
			seqOutHold <= {seq1[39], seq0[39]};
			
			seq0 <= {seq0[38:0], seq0[39]};
			seq1 <= {seq1[38:0], seq1[39]};
		
		end
		else begin
		
			seq0 <= seq0;
			seq1 <= seq1;
			seqOutHold <= 2'b0;
		
		end
	end
	
	assign seqOut = seqOutHold;
	
endmodule