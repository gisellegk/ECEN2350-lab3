module blinker(input clock, input state, input direction, output reg [2:0] left, output reg [2:0] right);

`include "verilog/params.vh" // quartus
//`include "../verilog/params.vh" // TEST ONLY

reg [2:0]counter;

initial begin
counter = 3'b0;
end

always @(posedge clock) begin
	left = 3'b000;
	right = 3'b000; 
	 
	 if(state == 0) begin 
	 //if(state == TURN) begin 
    // do TURN logic
		if (direction == LEFT) begin
			if(counter == 0) left[2] = 1;
			if (counter == 1) left [1] = 1;
			if (counter == 2) left [0] = 1;
			end
		else if (direction == RIGHT) begin
			if(counter == 0) right[0] = 1;
			if (counter == 1) right [1] = 1;
			if (counter == 2) right [2] = 1;
			//right = 3'b111;
		end
    end
	 
	if(state == HAZARD) begin
    // do HAZARD logic
		if(counter>1) begin
		right = 3'b111;
		left = 3'b111;
		end
    end
	 
	 //if (state == IDLE)begin
		//right = 3'b000;
		//left = 3'b000;
	 //end

	 
	 
	 counter = counter +1;
	 if (counter== 4) counter = 0;
end

endmodule