module WaveMaker(input enable, reset, clock, input[14:0] depth, output[14:0] address, output playing);
	
	parameter IDLE = 1'b0, PLAY = 1'b1;
	
	reg currentState, nextState;
	initial currentState = IDLE;

	
	reg [14:0] nextAddress;
	initial nextAddress = 15'b0;
	
	always @ (posedge clock) begin
			case (currentState)
				IDLE: begin
					nextAddress <= 15'b0;
					if (enable)
						nextState <= PLAY;
					else
						nextState <= IDLE;
				end
				PLAY: begin
					if (address >= depth || reset) begin
						nextAddress <= 15'b0;
						nextState <= IDLE;
					end
					else begin
						nextAddress <= nextAddress + 15'b000000000000001;
						nextState <= PLAY;
					end
				end
			endcase
	end
	
		assign playing = (currentState == PLAY);
		assign address = nextAddress;
	
	always @(nextState) begin
			currentState <= nextState;
	end
		
endmodule