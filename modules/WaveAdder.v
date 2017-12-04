module WaveAdder (input[15:0] playing, input[5:0] wave0,
wave1,
wave2,
wave3,
wave4,
wave5,
wave6,
wave7,
wave8,
wave9,
wave10,
wave11,
wave12,
wave13,
wave14,
wave15,

output[5:0] newWave);
	
	wire [8:0] sum;
	assign sum = wave0 + wave1 + wave2 + wave3 + wave4 + wave5 + wave6 + wave7 + wave8 + wave9 + wave10 + wave11 + wave12 + wave13 + wave14 + wave15;
		
	reg [4:0] numWaves;
	
	integer i;
	always @(*)	begin
		numWaves = 5'b0;
		for (i = 0; i < 16; i = i + 1) begin
			numWaves = numWaves + playing[i];
		end
	end

	wire[8:0] quotient;
	wire[4:0] remain;
	
	Divider waveDivider(.denom(numWaves), .numer(sum), .quotient(quotient), .remain(remain));
	
	assign newWave = quotient[5:0];
		
endmodule
	

	
			
	