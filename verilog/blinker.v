module blinker(input clock, input state, input direction, output reg [2:0] left, output reg [2:0] right);

`include "verilog/params.vh" // quartus
//`include "../verilog/params.vh" // TEST ONLY

reg counter;

initial begin
counter = 0;
end

always @(clock) begin
	left = 0;
	right = 0; 
    if(state == TURN) begin
    // do TURN logic
		if (direction == LEFT) begin
			if(counter == 0) left[0] = 1;
			if (counter == 1) left [1] = 1;
			if (counter == 2) left [2] = 1;
			
		end
		else if (direction == RIGHT) begin
			if(counter == 0) right[0] = 1;
			if (counter == 1) right [1] = 1;
			if (counter == 2) right [2] = 1;
		end
		
    end else if(state == HAZARD) begin
    // do HAZARD logic
		if(counter>1) begin
		right = 1;
		left = 1;
		end
    end
	 
	 counter = counter +1;
	 if (counter== 4) counter = 0;
end

endmodule