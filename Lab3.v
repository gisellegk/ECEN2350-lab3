
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module Lab3(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);

`include "verilog/params.vh" // quartus
//`include "../verilog/params.vh" // TEST ONLY


//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [1:0] current_state;
wire [1:0] next_state;
wire clock; 

wire reset;
wire hazard;
wire turn;

assign reset = ~KEY[0];
assign hazard = SW[0];
assign turn = SW[1];
assign left = KEY[1];

div10M_1 divider(ADC_CLK_10, ~reset, clock);
//assign clock = ADC_CLK_10; // TEST ONLY

next_state_logic nextStateLogic(reset, turn, hazard, next_state);

//DEBUG: decimal point blinks as clock, HEX0 displays state (0 = idle 1 = hazard 2 = turn)
sevensegment hex_0(current_state, 0, clock, reset, HEX0);
sevensegment hex_1(0, 0, 0, 1, HEX1);
sevensegment hex_2(0, 0, 0, 1, HEX2);
sevensegment hex_3(0, 0, 0, 1, HEX3);
sevensegment hex_4(0, 0, 0, 1, HEX4);
sevensegment hex_5(0, 0, 0, 1, HEX5);

//=======================================================
//  Structural coding
//=======================================================
initial begin
	current_state = IDLE;
end

always @(posedge clock) begin
	current_state = next_state;
end

endmodule
