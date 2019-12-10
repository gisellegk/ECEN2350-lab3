
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

	//////////// KEY //////////.
	input 		     [1:0]		KEY,

	//////////// LED ///////////
	output		     [9:0]		LEDR,

	//////////// SW ////////////
	input 		     [9:0]		SW
	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N
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
assign direction = KEY[1];

div10M_5 divider(ADC_CLK_10, 1, clock);
//assign clock = ADC_CLK_10; // TEST ONLY

next_state_logic nextStateLogic(reset, turn, hazard, next_state);

//DEBUG: decimal point blinks as clock, HEX0 displays state (0 = idle 1 = hazard 2 = turn)
sevensegment hex_0(current_state, 0, clock, 0, HEX0);
sevensegment hex_1(0, 0, 0, 1, HEX1);
sevensegment hex_2(0, 0, 0, 1, HEX2);
sevensegment hex_3(0, 0, 0, 1, HEX3);
sevensegment hex_4(0, 0, 0, 1, HEX4);
sevensegment hex_5(0, 0, 0, 1, HEX5);

//blinker b(clock, TURN , direction, LEDR[2:0], LEDR[9:7]);
blinker b(clock, current_state, direction, LEDR[2:0], LEDR[9:7]);

assign LEDR[6:3] = 4'b0000;	

//=======================================================
//  Structural coding
//=======================================================
initial begin
	current_state = IDLE;
	counter = 0;
end

wire [1:0] next_state_auto;

reg [1:0] address;

reg [4:0] counter;


always @(posedge clock) begin
		if (SW[9]) begin
		   current_state = next_state_auto;
			if(counter != 25) //count to 25
			counter = counter + 1'b1;
			else begin
			address = address + 1'b1;
			counter = 0;
			end
		end 
		else current_state = next_state;
end


mem mem1(address,clock,next_state_auto);


	
endmodule
