module blinker(input clock, input [1:0]state, output reg [2:0] left, output reg [2:0] right);

`include "verilog/params.vh" // quartus
//`include "../verilog/params.vh" // TEST ONLY

reg [2:0]counter;
reg [1:0] oldstate;

initial begin
counter = 3'b0;
oldstate = IDLE;
end

always @(posedge clock) begin
	left = 3'b000;
	right = 3'b000;  
	 //if(state == 0) begin 
	 if(state == LTURN) begin 
	 	if(~(oldstate==LTURN)) counter = 3;
		if(counter == 0) left[0] = 1;
		if (counter == 1) left [1] = 1;
		if (counter == 2) left[2] = 1;
	end
	else if (state == RTURN) begin
		if(~(oldstate==RTURN)) counter = 3;
		if(counter == 0) right[2] = 1;
		if (counter == 1) right [1] = 1;
		if (counter == 2) right [0] = 1;
		//right = 3'b111
    end
	 
	if(state == HAZARD) begin
    // do HAZARD logic
	    if(~(oldstate==HAZARD)) counter = 0;
		if(counter>1) begin
		right = 3'b111;
		left = 3'b111;
		end
    end
	 
	 if (state == IDLE)begin
		right = 3'b000;
		left = 3'b000;
	 end
	 oldstate = state;
	 counter = counter +1;
	 if (counter== 4) counter = 0;
end

endmodule