module Simulation(input mode, input playEn, input[1:0] btns, reset, input clock);
	
	localparam depth0 = 15'b010000011000011;
	localparam depth1 = 15'b010000011000011;
		
	wire [14:0] address0, address1;
			
	wire [1:0] seqOut;
	wire [14:0] addressch0, addressch1;
	wire [1:0] chEn;

	Channel ch0 ( .mode( mode ), .playEn( playEn ), .clock( clock ), .data( btns ), .seqOut( seqOut ) );

	wire [1:0] rden;

	WaveMaker wm0 ( .enable(btns[0]), .reset(reset[0]), .clock( clock ), .depth( depth0 ), .address( address0 ), .playing( rden[0] ) );
	WaveMaker wm1 ( .enable(btns[1]), .reset(reset[1]), .clock( clock ), .depth( depth1 ), .address( address1 ), .playing( rden[1] ) );	

	WaveMaker wmch0 ( .enable( seqOut[0] ), .reset( reset[0] ), .clock( clock ), .depth( depth0 ), .address( addressch0 ), .playing( chEn[0] ) );
	WaveMaker wmch1 ( .enable( seqOut[1] ), .reset( reset[0] ), .clock( clock ), .depth( depth1 ), .address( addressch1 ), .playing( chEn[1] ) );
	
	
	wire [15:0] soundOut0, soundOut1;
			
	wire [1:0] enable;
	Enabler ench0 ( .btn(rden[0]), .ch(chEn[0]), .enable(enable[0]) );
	Enabler ench1 ( .btn(rden[1]), .ch(chEn[1]), .enable(enable[1]) );

	
	reg [14:0] adRegOut0, adRegOut1;
	
	initial adRegOut0 = 15'b0;
	initial adRegOut1 = 15'b0;
	
	wire [14:0] adOut0, adOut1;

	always @ (posedge clock) begin

		if (rden[0])
			adRegOut0 = address0;
		else if (chEn[0])
			adRegOut0 = addressch0;
		
		if (rden[1])
			adRegOut1 = address1;
		else if (chEn[1])
			adRegOut1 = addressch1;

	end

	assign adOut0 = adRegOut0;
	assign adOut1 = adRegOut1;
	
		
	RAM0 r0( .address( adOut0 ), .clock(clock), .rden( enable[0] ), .q(soundOut0));
	RAM1 r1( .address( adOut1 ), .clock(clock), .rden( enable[1] ), .q(soundOut1));

	
	reg [15:0] soundToAddReg0, soundToAddReg1;
	
	initial soundToAddReg0 = 16'b0;
	initial soundToAddReg1 = 16'b0;
	
	wire [15:0] soundToAdd0, soundToAdd1;

	always @ (posedge clock) begin
		if (enable[0])
			soundToAddReg0 = soundOut0;
		else
			soundToAddReg0 = 16'b0;
			
		if (enable[1])
			soundToAddReg1 = soundOut1;
		else
			soundToAddReg1 = 16'b0;
	end
	
	assign soundToAdd0 = soundToAddReg0;
	assign soundToAdd1 = soundToAddReg1;
			
	wire [15:0] sound16, sound32;
	assign sound16 = soundToAdd0;
	assign sound32 = soundToAdd1;
	
endmodule