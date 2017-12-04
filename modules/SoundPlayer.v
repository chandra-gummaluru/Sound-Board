module SoundPlayer(	
	//inputs
	//numSounds
	KEY,
	SW,
	
	//GPIO
	GPIO_0,
	CLOCK_50,
	
	AUD_ADCDAT,
	
	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	FPGA_I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,

	FPGA_I2C_SCLK
);

//PARAMETERS FOR AUDIO CONTROLLER

input				AUD_ADCDAT;
// Bidirectionals
inout				AUD_BCLK;
inout				AUD_ADCLRCK;
inout				AUD_DACLRCK;
inout				FPGA_I2C_SDAT;
// Outputs
output				AUD_XCK;
output				AUD_DACDAT;
output				FPGA_I2C_SCLK;

//external IO
input [35:0] GPIO_0;
input [3:0] KEY;
input [9:0] SW;
input CLOCK_50;


//44kHz Clock
parameter[27:0] rate44k = 28'b0000000000000000010001101100; // 44.100 kHz = 1 132 counts @ 50MHz / count
wire clock44kk;

RateDivider rd0 ( .reset(~KEY[0]), .rate(rate44k), .clk(CLOCK_50), .out(clock44kk) );

//25Hz clock44k
parameter[27:0] rate25 = 28'b0000101111101011110000011111; //25 Hz = 12500000 counts @ 50MHz / count
wire clock25;

RateDivider rd1 ( .reset(~KEY[0]), .rate(rate25), .clk(CLOCK_50), .out(clock25) );
  
//depths of each sound file
localparam depth0 = 15'b010001001110100,
depth1 = 15'b010001001110100,
depth2 = 15'b010001001110100,
depth3 = 15'b010111101001111,
depth4 = 15'b010001001110100,
depth5 = 15'b010001001110100,
depth6 = 15'b010001001110100,
depth7 = 15'b010000010110011,
depth8 = 15'b010001001110100,
depth9 = 15'b010001001110100,
depth10 = 15'b010001001110100,
depth11 = 15'b110011001001000,
depth12 = 15'b010000011000110,
depth13 = 15'b010000011000110,
depth14 = 15'b010000011000110,
depth15 = 15'b110011001001000;


wire[15:0] chData;

//assign channel data to inputs
assign chData = {1'b0,SW[3],SW[4],SW[5],SW[6],SW[7],SW[8], SW[9], GPIO_0[7],GPIO_0[6],GPIO_0[5],GPIO_0[4],GPIO_0[3],GPIO_0[2],GPIO_0[1],GPIO_0[0]};

//channel output sequences
wire [15:0] ch0SeqOut, ch1SeqOut, ch2SeqOut;

//assign channel output sequences
Channel ch0 (.mode(~KEY[1]), .clear(~KEY[0]), .playEn(SW[0]), .clock(clock44k), .data(chData), .seqOut(ch0SeqOut));
Channel ch1 (.mode(~KEY[2]), .clear(~KEY[0]), .playEn(SW[1]), .clock(clock44k), .data(chData), .seqOut(ch1SeqOut));
Channel ch2 (.mode(~KEY[3]), .clear(~KEY[0]), .playEn(SW[2]), .clock(clock44k), .data(chData), .seqOut(ch2SeqOut));

	
//live addresses
wire [14:0] liveAd0, liveAd1, liveAd2, liveAd3, liveAd4, liveAd5,
liveAd6, liveAd7, liveAd8, liveAd9, liveAd10, liveAd11, liveAd12,
liveAd13, liveAd14, liveAd15;

//channel addresses
wire [14:0] ch0Ad0, ch0Ad1, ch0Ad2, ch0Ad3, ch0Ad4, ch0Ad5, ch0Ad6, ch0Ad7, ch0Ad8, ch0Ad9, ch0Ad10, ch0Ad11, ch0Ad12, ch0Ad13, ch0Ad14, ch0Ad15;
wire [14:0] ch1Ad0, ch1Ad1, ch1Ad2, ch1Ad3, ch1Ad4, ch1Ad5, ch1Ad6, ch1Ad7, ch1Ad8, ch1Ad9, ch1Ad10, ch1Ad11, ch1Ad12, ch1Ad13, ch1Ad14, ch1Ad15;
wire [14:0] ch2Ad0, ch2Ad1, ch2Ad2, ch2Ad3, ch2Ad4, ch2Ad5, ch2Ad6, ch2Ad7, ch2Ad8, ch2Ad9, ch2Ad10, ch2Ad11, ch2Ad12, ch2Ad13, ch2Ad14, ch2Ad15;

//enables
wire [15:0] liveEn, ch0En, ch1En, ch2En;


//live
WaveMaker wm0 ( .enable( GPIO_0[0] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth0 ), .address( liveAd0 ), .playing( liveEn[0] ) );
WaveMaker wm1 ( .enable( GPIO_0[1] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth1 ), .address( liveAd1 ), .playing( liveEn[1] ) );
WaveMaker wm2 ( .enable( GPIO_0[2] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth2 ), .address( liveAd2 ), .playing( liveEn[2] ) );
WaveMaker wm3 ( .enable( GPIO_0[3] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth3 ), .address( liveAd3 ), .playing( liveEn[3] ) );
WaveMaker wm4 ( .enable( GPIO_0[4] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth4 ), .address( liveAd4 ), .playing( liveEn[4] ) );
WaveMaker wm5 ( .enable( GPIO_0[5] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth5 ), .address( liveAd5 ), .playing( liveEn[5] ) );
WaveMaker wm6 ( .enable( GPIO_0[6] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth6 ), .address( liveAd6 ), .playing( liveEn[6] ) );
WaveMaker wm7 ( .enable( GPIO_0[7] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth7 ), .address( liveAd7 ), .playing( liveEn[7] ) );
WaveMaker wm8 ( .enable( SW[9] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth8 ), .address( liveAd8 ), .playing( liveEn[8] ) );
WaveMaker wm9 ( .enable( SW[8] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth9 ), .address( liveAd9 ), .playing( liveEn[9] ) );
WaveMaker wm10 ( .enable( SW[7] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth10 ), .address( liveAd10 ), .playing( liveEn[10] ) );
WaveMaker wm11 ( .enable( SW[6] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth11 ), .address( liveAd11 ), .playing( liveEn[11] ) );
WaveMaker wm12 ( .enable( SW[5] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth12 ), .address( liveAd12 ), .playing( liveEn[12] ) );
WaveMaker wm13 ( .enable( SW[4] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth13 ), .address( liveAd13 ), .playing( liveEn[13] ) );
WaveMaker wm14 ( .enable( SW[3] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth14 ), .address( liveAd14 ), .playing( liveEn[14] ) );
WaveMaker wm15 ( .enable( 0 ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth15 ), .address( liveAd15 ), .playing( liveEn[15] ) );

//channel 0

WaveMaker ch0wm0 ( .enable( ch0SeqOut[0] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth0 ), .address( ch0Ad0 ), .playing( ch0En[0] ) );
WaveMaker ch0wm1 ( .enable( ch0SeqOut[1] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth1 ), .address( ch0Ad1 ), .playing( ch0En[1] ) );
WaveMaker ch0wm2 ( .enable( ch0SeqOut[2] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth2 ), .address( ch0Ad2 ), .playing( ch0En[2] ) );
WaveMaker ch0wm3 ( .enable( ch0SeqOut[3] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth3 ), .address( ch0Ad3 ), .playing( ch0En[3] ) );
WaveMaker ch0wm4 ( .enable( ch0SeqOut[4] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth4 ), .address( ch0Ad4 ), .playing( ch0En[4] ) );
WaveMaker ch0wm5 ( .enable( ch0SeqOut[5] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth5 ), .address( ch0Ad5 ), .playing( ch0En[5] ) );
WaveMaker ch0wm6 ( .enable( ch0SeqOut[6] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth6 ), .address( ch0Ad6 ), .playing( ch0En[6] ) );
WaveMaker ch0wm7 ( .enable( ch0SeqOut[7] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth7 ), .address( ch0Ad7 ), .playing( ch0En[7] ) );
WaveMaker ch0wm8 ( .enable( ch0SeqOut[8] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth8 ), .address( ch0Ad8 ), .playing( ch0En[8] ) );
WaveMaker ch0wm9 ( .enable( ch0SeqOut[9] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth9 ), .address( ch0Ad9 ), .playing( ch0En[9] ) );
WaveMaker ch0wm10 ( .enable( ch0SeqOut[10] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth10 ), .address( ch0Ad10 ), .playing( ch0En[10] ) );
WaveMaker ch0wm11 ( .enable( ch0SeqOut[11] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth11 ), .address( ch0Ad11 ), .playing( ch0En[11] ) );
WaveMaker ch0wm12 ( .enable( ch0SeqOut[12] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth12 ), .address( ch0Ad12 ), .playing( ch0En[12] ) );
WaveMaker ch0wm13 ( .enable( ch0SeqOut[13] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth13 ), .address( ch0Ad13 ), .playing( ch0En[13] ) );
WaveMaker ch0wm14 ( .enable( ch0SeqOut[14] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth14 ), .address( ch0Ad14 ), .playing( ch0En[14] ) );
WaveMaker ch0wm15 ( .enable( ch0SeqOut[15] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth15 ), .address( ch0Ad15 ), .playing( ch0En[15] ) );

//channel 1

WaveMaker ch1wm0 ( .enable( ch1SeqOut[0] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth0 ), .address( ch1Ad0 ), .playing( ch1En[0] ) );
WaveMaker ch1wm1 ( .enable( ch1SeqOut[1] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth1 ), .address( ch1Ad1 ), .playing( ch1En[1] ) );
WaveMaker ch1wm2 ( .enable( ch1SeqOut[2] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth2 ), .address( ch1Ad2 ), .playing( ch1En[2] ) );
WaveMaker ch1wm3 ( .enable( ch1SeqOut[3] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth3 ), .address( ch1Ad3 ), .playing( ch1En[3] ) );
WaveMaker ch1wm4 ( .enable( ch1SeqOut[4] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth4 ), .address( ch1Ad4 ), .playing( ch1En[4] ) );
WaveMaker ch1wm5 ( .enable( ch1SeqOut[5] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth5 ), .address( ch1Ad5 ), .playing( ch1En[5] ) );
WaveMaker ch1wm6 ( .enable( ch1SeqOut[6] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth6 ), .address( ch1Ad6 ), .playing( ch1En[6] ) );
WaveMaker ch1wm7 ( .enable( ch1SeqOut[7] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth7 ), .address( ch1Ad7 ), .playing( ch1En[7] ) );
WaveMaker ch1wm8 ( .enable( ch1SeqOut[8] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth8 ), .address( ch1Ad8 ), .playing( ch1En[8] ) );
WaveMaker ch1wm9 ( .enable( ch1SeqOut[9] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth9 ), .address( ch1Ad9 ), .playing( ch1En[9] ) );
WaveMaker ch1wm10 ( .enable( ch1SeqOut[10] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth10 ), .address( ch1Ad10 ), .playing( ch1En[10] ) );
WaveMaker ch1wm11 ( .enable( ch1SeqOut[11] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth11 ), .address( ch1Ad11 ), .playing( ch1En[11] ) );
WaveMaker ch1wm12 ( .enable( ch1SeqOut[12] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth12 ), .address( ch1Ad12 ), .playing( ch1En[12] ) );
WaveMaker ch1wm13 ( .enable( ch1SeqOut[13] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth13 ), .address( ch1Ad13 ), .playing( ch1En[13] ) );
WaveMaker ch1wm14 ( .enable( ch1SeqOut[14] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth14 ), .address( ch1Ad14 ), .playing( ch1En[14] ) );
WaveMaker ch1wm15 ( .enable( ch1SeqOut[15] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth15 ), .address( ch1Ad15 ), .playing( ch1En[15] ) );

//channel 2

WaveMaker ch2wm0 ( .enable( ch2SeqOut[0] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth0 ), .address( ch2Ad0 ), .playing( ch2En[0] ) );
WaveMaker ch2wm1 ( .enable( ch2SeqOut[1] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth1 ), .address( ch2Ad1 ), .playing( ch2En[1] ) );
WaveMaker ch2wm2 ( .enable( ch2SeqOut[2] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth2 ), .address( ch2Ad2 ), .playing( ch2En[2] ) );
WaveMaker ch2wm3 ( .enable( ch2SeqOut[3] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth3 ), .address( ch2Ad3 ), .playing( ch2En[3] ) );
WaveMaker ch2wm4 ( .enable( ch2SeqOut[4] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth4 ), .address( ch2Ad4 ), .playing( ch2En[4] ) );
WaveMaker ch2wm5 ( .enable( ch2SeqOut[5] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth5 ), .address( ch2Ad5 ), .playing( ch2En[5] ) );
WaveMaker ch2wm6 ( .enable( ch2SeqOut[6] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth6 ), .address( ch2Ad6 ), .playing( ch2En[6] ) );
WaveMaker ch2wm7 ( .enable( ch2SeqOut[7] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth7 ), .address( ch2Ad7 ), .playing( ch2En[7] ) );
WaveMaker ch2wm8 ( .enable( ch2SeqOut[8] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth8 ), .address( ch2Ad8 ), .playing( ch2En[8] ) );
WaveMaker ch2wm9 ( .enable( ch2SeqOut[9] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth9 ), .address( ch2Ad9 ), .playing( ch2En[9] ) );
WaveMaker ch2wm10 ( .enable( ch2SeqOut[10] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth10 ), .address( ch2Ad10 ), .playing( ch2En[10] ) );
WaveMaker ch2wm11 ( .enable( ch2SeqOut[11] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth11 ), .address( ch2Ad11 ), .playing( ch2En[11] ) );
WaveMaker ch2wm12 ( .enable( ch2SeqOut[12] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth12 ), .address( ch2Ad12 ), .playing( ch2En[12] ) );
WaveMaker ch2wm13 ( .enable( ch2SeqOut[13] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth13 ), .address( ch2Ad13 ), .playing( ch2En[13] ) );
WaveMaker ch2wm14 ( .enable( ch2SeqOut[14] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth14 ), .address( ch2Ad14 ), .playing( ch2En[14] ) );
WaveMaker ch2wm15 ( .enable( ch2SeqOut[15] ), .reset( ~KEY[0] ), .clock( clock44k ), .depth( depth15 ), .address( ch2Ad15 ), .playing( ch2En[15] ) );


wire[15:0] enable;
wire [14:0] adOut0, adOut1, adOut2, adOut3, adOut4, adOut5, adOut6, adOut7, adOut8, adOut9, adOut10, adOut11, adOut12, adOut13, adOut14, adOut15; 

Addresser adr0(.clock(clock44k), .ad0(liveAd0), .ad1(ch0Ad0), .ad2(ch1Ad0), .ad3(ch2Ad0), .en0(liveEn[0]), .en1(ch0En[0]), .en2(ch1En[0]), .en3(ch2En[0]), .adOut(adOut0), .en(enable[0]));
Addresser adr1(.clock(clock44k), .ad0(liveAd1), .ad1(ch0Ad1), .ad2(ch1Ad1), .ad3(ch2Ad1), .en0(liveEn[1]), .en1(ch0En[1]), .en2(ch1En[1]), .en3(ch2En[1]), .adOut(adOut1), .en(enable[1]));
Addresser adr2(.clock(clock44k), .ad0(liveAd2), .ad1(ch0Ad2), .ad2(ch1Ad2), .ad3(ch2Ad2), .en0(liveEn[2]), .en1(ch0En[2]), .en2(ch1En[2]), .en3(ch2En[2]), .adOut(adOut2), .en(enable[2]));
Addresser adr3(.clock(clock44k), .ad0(liveAd3), .ad1(ch0Ad3), .ad2(ch1Ad3), .ad3(ch2Ad3), .en0(liveEn[3]), .en1(ch0En[3]), .en2(ch1En[3]), .en3(ch2En[3]), .adOut(adOut3), .en(enable[3]));
Addresser adr4(.clock(clock44k), .ad0(liveAd4), .ad1(ch0Ad4), .ad2(ch1Ad4), .ad3(ch2Ad4), .en0(liveEn[4]), .en1(ch0En[4]), .en2(ch1En[4]), .en3(ch2En[4]), .adOut(adOut4), .en(enable[4]));
Addresser adr5(.clock(clock44k), .ad0(liveAd5), .ad1(ch0Ad5), .ad2(ch1Ad5), .ad3(ch2Ad5), .en0(liveEn[5]), .en1(ch0En[5]), .en2(ch1En[5]), .en3(ch2En[5]), .adOut(adOut5), .en(enable[5]));
Addresser adr6(.clock(clock44k), .ad0(liveAd6), .ad1(ch0Ad6), .ad2(ch1Ad6), .ad3(ch2Ad6), .en0(liveEn[6]), .en1(ch0En[6]), .en2(ch1En[6]), .en3(ch2En[6]), .adOut(adOut6), .en(enable[6]));
Addresser adr7(.clock(clock44k), .ad0(liveAd7), .ad1(ch0Ad7), .ad2(ch1Ad7), .ad3(ch2Ad7), .en0(liveEn[7]), .en1(ch0En[7]), .en2(ch1En[7]), .en3(ch2En[7]), .adOut(adOut7), .en(enable[7]));
Addresser adr8(.clock(clock44k), .ad0(liveAd8), .ad1(ch0Ad8), .ad2(ch1Ad8), .ad3(ch2Ad8), .en0(liveEn[8]), .en1(ch0En[8]), .en2(ch1En[8]), .en3(ch2En[8]), .adOut(adOut8), .en(enable[8]));
Addresser adr9(.clock(clock44k), .ad0(liveAd9), .ad1(ch0Ad9), .ad2(ch1Ad9), .ad3(ch2Ad9), .en0(liveEn[9]), .en1(ch0En[9]), .en2(ch1En[9]), .en3(ch2En[9]), .adOut(adOut9), .en(enable[9]));
Addresser adr10(.clock(clock44k), .ad0(liveAd10), .ad1(ch0Ad10), .ad2(ch1Ad10), .ad3(ch2Ad10), .en0(liveEn[10]), .en1(ch0En[10]), .en2(ch1En[10]), .en3(ch2En[10]), .adOut(adOut10), .en(enable[10]));
Addresser adr11(.clock(clock44k), .ad0(liveAd11), .ad1(ch0Ad11), .ad2(ch1Ad11), .ad3(ch2Ad11), .en0(liveEn[11]), .en1(ch0En[11]), .en2(ch1En[11]), .en3(ch2En[11]), .adOut(adOut11), .en(enable[11]));
Addresser adr12(.clock(clock44k), .ad0(liveAd12), .ad1(ch0Ad12), .ad2(ch1Ad12), .ad3(ch2Ad12), .en0(liveEn[12]), .en1(ch0En[12]), .en2(ch1En[12]), .en3(ch2En[12]), .adOut(adOut12), .en(enable[12]));
Addresser adr13(.clock(clock44k), .ad0(liveAd13), .ad1(ch0Ad13), .ad2(ch1Ad13), .ad3(ch2Ad13), .en0(liveEn[13]), .en1(ch0En[13]), .en2(ch1En[13]), .en3(ch2En[13]), .adOut(adOut13), .en(enable[13]));
Addresser adr14(.clock(clock44k), .ad0(liveAd14), .ad1(ch0Ad14), .ad2(ch1Ad14), .ad3(ch2Ad14), .en0(liveEn[14]), .en1(ch0En[14]), .en2(ch1En[14]), .en3(ch2En[14]), .adOut(adOut14), .en(enable[14]));
Addresser adr15(.clock(clock44k), .ad0(liveAd15), .ad1(ch0Ad15), .ad2(ch1Ad15), .ad3(ch2Ad15), .en0(liveEn[15]), .en1(ch0En[15]), .en2(ch1En[15]), .en3(ch2En[15]), .adOut(adOut15), .en(enable[15]));


wire [5:0] soundOut0, soundOut1, soundOut2, soundOut3, soundOut4, soundOut5,
soundOut6, soundOut7, soundOut8, soundOut9, soundOut10, soundOut11, soundOut12,
soundOut13, soundOut14, soundOut15;

nRAM0 r0( .address( adOut0 ), .clock(clock44k), .rden( enable[0] ), .q(soundOut0));
nRAM1 r1( .address( adOut1 ), .clock(clock44k), .rden( enable[1] ), .q(soundOut1));
nRAM2 r2( .address( adOut2 ), .clock(clock44k), .rden( enable[2] ), .q(soundOut2));
nRAM3 r3( .address( adOut3 ), .clock(clock44k), .rden( enable[3] ), .q(soundOut3));
nRAM4 r4( .address( adOut4 ), .clock(clock44k), .rden( enable[4] ), .q(soundOut4));
nRAM5 r5( .address( adOut5 ), .clock(clock44k), .rden( enable[5] ), .q(soundOut5));
nRAM6 r6( .address( adOut6 ), .clock(clock44k), .rden( enable[6] ), .q(soundOut6));
nRAM7 r7( .address( adOut7 ), .clock(clock44k), .rden( enable[7] ), .q(soundOut7));
nRAM8 r8( .address( adOut8 ), .clock(clock44k), .rden( enable[8] ), .q(soundOut8));
nRAM9 r9( .address( adOut9 ), .clock(clock44k), .rden( enable[9] ), .q(soundOut9));
nRAM10 r10( .address( adOut10 ), .clock(clock44k), .rden( enable[10] ), .q(soundOut10));
nRAM11 r11( .address( adOut11 ), .clock(clock44k), .rden( enable[11] ), .q(soundOut11));
nRAM12 r12( .address( adOut12 ), .clock(clock44k), .rden( enable[12] ), .q(soundOut12));
nRAM13 r13( .address( adOut13 ), .clock(clock44k), .rden( enable[13] ), .q(soundOut13));
nRAM14 r14( .address( adOut14 ), .clock(clock44k), .rden( enable[14] ), .q(soundOut14));
nRAM15 r15( .address( adOut15 ), .clock(clock44k), .rden( enable[15] ), .q(soundOut15));


wire [5:0] soundToAdd0, soundToAdd1, soundToAdd2, soundToAdd3, soundToAdd4, soundToAdd5,
soundToAdd6, soundToAdd7, soundToAdd8, soundToAdd9, soundToAdd10, soundToAdd11, soundToAdd12,
soundToAdd13, soundToAdd14, soundToAdd15;

Outputter opt0(.clock(clock44k), .en(enable[0]), .soundIn(soundOut0), .soundOut(soundToAdd0));
Outputter opt1(.clock(clock44k), .en(enable[1]), .soundIn(soundOut1), .soundOut(soundToAdd1));
Outputter opt2(.clock(clock44k), .en(enable[2]), .soundIn(soundOut2), .soundOut(soundToAdd2));
Outputter opt3(.clock(clock44k), .en(enable[3]), .soundIn(soundOut3), .soundOut(soundToAdd3));
Outputter opt4(.clock(clock44k), .en(enable[4]), .soundIn(soundOut4), .soundOut(soundToAdd4));
Outputter opt5(.clock(clock44k), .en(enable[5]), .soundIn(soundOut5), .soundOut(soundToAdd5));
Outputter opt6(.clock(clock44k), .en(enable[6]), .soundIn(soundOut6), .soundOut(soundToAdd6));
Outputter opt7(.clock(clock44k), .en(enable[7]), .soundIn(soundOut7), .soundOut(soundToAdd7));
Outputter opt8(.clock(clock44k), .en(enable[8]), .soundIn(soundOut8), .soundOut(soundToAdd8));
Outputter opt9(.clock(clock44k), .en(enable[9]), .soundIn(soundOut9), .soundOut(soundToAdd9));
Outputter opt10(.clock(clock44k), .en(enable[10]), .soundIn(soundOut10), .soundOut(soundToAdd10));
Outputter opt11(.clock(clock44k), .en(enable[11]), .soundIn(soundOut11), .soundOut(soundToAdd11));
Outputter opt12(.clock(clock44k), .en(enable[12]), .soundIn(soundOut12), .soundOut(soundToAdd12));
Outputter opt13(.clock(clock44k), .en(enable[13]), .soundIn(soundOut13), .soundOut(soundToAdd13));
Outputter opt14(.clock(clock44k), .en(enable[14]), .soundIn(soundOut14), .soundOut(soundToAdd14));
Outputter opt15(.clock(clock44k), .en(enable[15]), .soundIn(soundOut15), .soundOut(soundToAdd15));

wire [5:0] sound6;

WaveAdder wa0 (
	.newWave( sound6 ), .playing( enable ), 
	.wave0 ( soundToAdd0 ),
	.wave1 ( soundToAdd1 ),
	.wave2 ( soundToAdd2 ),
	.wave3 ( soundToAdd3 ),
	.wave4 ( soundToAdd4 ),
	.wave5 ( soundToAdd5 ),
	.wave6 ( soundToAdd6 ),
	.wave7 ( soundToAdd7 ),
	.wave8 ( soundToAdd8 ),
	.wave9 ( soundToAdd9 ),
	.wave10 ( soundToAdd10 ),
	.wave11 ( soundToAdd11 ),
	.wave12 ( soundToAdd12 ),
	.wave13 ( soundToAdd13 ),
	.wave14 ( soundToAdd14 ),
	.wave15 ( soundToAdd15 )
);

wire [31:0] sound32;

//concatenate to send audio adapter 32 bit sound
assign sound32 = {5'b0, sound6, 21'b0};																	

audioAdapter aa0 ( 
	.resetn(KEY[0]), 
	.soundOut(sound32), 
	.CLOCK_50(CLOCK_50), 
	.AUD_ADCDAT(AUD_ADCDAT), 
	.AUD_BCLK(AUD_BCLK), 
	.AUD_ADCLRCK(AUD_ADCLRCK),
	.AUD_DACLRCK(AUD_DACLRCK), 
	.FPGA_I2C_SDAT(FPGA_I2C_SDAT),
	.AUD_XCK(AUD_XCK),
	.AUD_DACDAT(AUD_DACDAT),
	.FPGA_I2C_SCLK(FPGA_I2C_SCLK)
);

endmodule