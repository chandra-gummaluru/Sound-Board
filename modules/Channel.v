module Channel(input mode, input clear, input playEn, input clock, input[15:0] data, output[15:0] seqOut);
	
	parameter PLAYING = 0, RECORDING = 1;

	wire currentState;
	
	reg nextState;
	initial nextState = PLAYING;

	
	always @(posedge mode) begin
		case (currentState)
			PLAYING:
				nextState <= RECORDING;
			RECORDING:
				nextState <= PLAYING;
		endcase
	end

	
	assign currentState = nextState;
	
	//the number of ticks at 44.1kHz equivalent to 0.25s.
	parameter countLimit = 14'd11025;
	
	reg [13:0] counter;
	initial counter = countLimit;
	
	//the new output pulse rate.
	reg pulse;
	initial pulse = 0;
	
	//40 input sequence samples (at 25Hz) fo each input.
	reg[39:0] seq0, seq1, seq2, seq3, seq4, seq5, seq6, seq7, seq8, seq9, seq10, seq11, seq12, seq13, seq14, seq15;
	
	initial seq0 = 40'b0;
	initial seq1 = 40'b0;
	initial seq2 = 40'b0;
	initial seq3 = 40'b0;
	initial seq4 = 40'b0;
	initial seq5 = 40'b0;
	initial seq6 = 40'b0;
	initial seq7 = 40'b0;
	initial seq8 = 40'b0;
	initial seq9 = 40'b0;
	initial seq10 = 40'b0;
	initial seq11 = 40'b0;
	initial seq12 = 40'b0;
	initial seq13 = 40'b0;
	initial seq14 = 40'b0;
	initial seq15 = 40'b0;
	
	//holds outgoing data until it is sent at the next clock tick.
	reg[15:0] seqOutHold;
	
	//holds incoming data until it is processed at the next clock tick.
	reg[15:0] dataHold;
	initial dataHold = 16'b0;
	
	always @(posedge clock) begin
		
		if (counter > 0) begin
			counter <= counter - 1'b1;
			pulse <= 0;
		end
		else begin
			counter <= countLimit;
			pulse <= 1;
		end
	
		case (currentState)
			PLAYING: begin
				if (playEn && pulse) begin
					
					//capture the rightmost bit of each sequence to output.
					seqOutHold <= {seq15[39], seq14[39], seq13[39], seq12[39], seq11[39], seq10[39], seq9[39], seq8[39], seq7[39], seq6[39], seq5[39], seq4[39], seq3[39], seq2[39], seq1[39], seq0[39]};
								
					//shift each sequence by 1 bit (with looping)
					seq0 <= {seq0[38:0], seq0[39]};
					seq1 <= {seq1[38:0], seq1[39]};
					seq2 <= {seq2[38:0], seq2[39]};
					seq3 <= {seq3[38:0], seq3[39]};
					seq4 <= {seq4[38:0], seq4[39]};
					seq5 <= {seq5[38:0], seq5[39]};
					seq6 <= {seq6[38:0], seq6[39]};
					seq7 <= {seq7[38:0], seq7[39]};
					seq8 <= {seq8[38:0], seq8[39]};
					seq9 <= {seq9[38:0], seq9[39]};
					seq10 <= {seq10[38:0], seq10[39]};
					seq11 <= {seq11[38:0], seq11[39]};
					seq12 <= {seq12[38:0], seq12[39]};
					seq13 <= {seq13[38:0], seq13[39]};
					seq14 <= {seq14[38:0], seq14[39]};
					seq15 <= {seq15[38:0], seq15[39]};
				
				end
				else begin
				
					//keep the last available data
					
					seq0 <= seq0;
					seq1 <= seq1;
					seq2 <= seq2;
					seq3 <= seq3;
					seq4 <= seq4;
					seq5 <= seq5;
					seq6 <= seq6;
					seq7 <= seq7;
					seq8 <= seq8;
					seq9 <= seq9;
					seq10 <= seq10;
					seq11 <= seq11;
					seq12 <= seq12;
					seq13 <= seq13;
					seq14 <= seq14;
					seq15 <= seq15;
					
					seqOutHold <= 16'b0;

				end
			end
			RECORDING: begin
			
				//capture and hold incoming data
				dataHold <= dataHold | data;
			
				if (pulse) begin

					// shift data into registers
					
					seq0 <= {seq0[38:0], dataHold[0]};
					seq1 <= {seq1[38:0], dataHold[1]};
					seq2 <= {seq2[38:0], dataHold[2]};
					seq3 <= {seq3[38:0], dataHold[3]};
					seq4 <= {seq4[38:0], dataHold[4]};
					seq5 <= {seq5[38:0], dataHold[5]};
					seq6 <= {seq6[38:0], dataHold[6]};
					seq7 <= {seq7[38:0], dataHold[7]};
					seq8 <= {seq8[38:0], dataHold[8]};
					seq9 <= {seq9[38:0], dataHold[9]};
					seq10 <= {seq10[38:0], dataHold[10]};
					seq11 <= {seq11[38:0], dataHold[11]};
					seq12 <= {seq12[38:0], dataHold[12]};
					seq13 <= {seq13[38:0], dataHold[13]};
					seq14 <= {seq14[38:0], dataHold[14]};
					seq15 <= {seq15[38:0], dataHold[15]};
					
					dataHold <= 16'b0;

				end
				else begin
					
					// keep last available data
					
					seq0 <= seq0;
					seq1 <= seq1;
					seq2 <= seq2;
					seq3 <= seq3;
					seq4 <= seq4;
					seq5 <= seq5;
					seq6 <= seq6;
					seq7 <= seq7;
					seq8 <= seq8;
					seq9 <= seq9;
					seq10 <= seq10;
					seq11 <= seq11;
					seq12 <= seq12;
					seq13 <= seq13;
					seq14 <= seq14;
					seq15 <= seq15;
					
					seqOutHold <= 16'b0;
				
				end
				
			end
		endcase
	end
	
	assign seqOut = seqOutHold;
	
endmodule