module Enabler ( input live, ch0, ch1, ch2, output enable);

	//determine whether live playback or any channels are active
	assign enable = live | ch0 | ch1 | ch2;

endmodule