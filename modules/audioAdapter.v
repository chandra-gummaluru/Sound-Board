module audioAdapter(
/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/
	// Inputs
	
	CLOCK_50,
	//output from module [1]
	//SIGNAL_STRENGTH
	soundOut,
	
	resetn,

	//AUD_ADCDAT, AUD_DACDAT, AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK, I2C_SDAT, I2C_SCLK and AUD_XCK
	//off-chip lines to be connected to the correspondingly named pins, as defined in the DE1_SoC.qsf file.
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



/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input				CLOCK_50;
//DOES SIGNAL STRENGTH MATTER?!?!?!?!
//[1]
//input		[3:0]	SIGNAL_STRENGTH;
//[2]
input		[31:0]	soundOut;

//ACTIVE LOW reset FOR KEY[0]
input 				resetn;

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



/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires
wire				audio_in_available;

//to be specified with SELECTED_SOUND
wire		[31:0]	left_channel_audio_in;
wire		[31:0]	right_channel_audio_in;

wire					read_audio_in;

wire					audio_out_allowed;
wire		[31:0]	left_channel_audio_out;
wire		[31:0]	right_channel_audio_out;
wire					write_audio_out;




//soundOut goes into the wire and gets played (hopefully)
wire [31:0] sound;
assign sound = soundOut;


assign read_audio_in			= 1'b0;
assign left_channel_audio_out	= sound;
assign right_channel_audio_out	= sound;
assign write_audio_out			= 1'b1;



/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

Audio_Controller Audio_Controller (
	// Inputs
	.CLOCK_50						(CLOCK_50),
	.reset							(~resetn),

	.clear_audio_in_memory		(),
	.read_audio_in				(read_audio_in),
	
	.clear_audio_out_memory		(),
	.left_channel_audio_out		(left_channel_audio_out),
	.right_channel_audio_out	(right_channel_audio_out),
	.write_audio_out			(write_audio_out),

	.AUD_ADCDAT					(AUD_ADCDAT),

	// Bidirectionals
	.AUD_BCLK					(AUD_BCLK),
	.AUD_ADCLRCK				(AUD_ADCLRCK),
	.AUD_DACLRCK				(AUD_DACLRCK),


	// Outputs
	.audio_in_available			(audio_in_available),
	.left_channel_audio_in		(left_channel_audio_in),
	.right_channel_audio_in		(right_channel_audio_in),

	.audio_out_allowed			(audio_out_allowed),

	.AUD_XCK					(AUD_XCK),
	.AUD_DACDAT					(AUD_DACDAT)

);


//MIC INPUT

avconf #(.USE_MIC_INPUT(1)) avc (
	.FPGA_I2C_SCLK					(FPGA_I2C_SCLK),
	.FPGA_I2C_SDAT					(FPGA_I2C_SDAT),
	.CLOCK_50					(CLOCK_50),
	.reset						(~resetn)
);


endmodule

