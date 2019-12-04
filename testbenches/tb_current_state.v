//iverilog -o tb_current_state.out tb_current_state.v ../verilog/*.v ../Lab3.v;
// vvp tb_current_state.out > tb_next_state.txt; 
// gtkwave tb_current_state.vcd -g

/*
*  this testbench demonstrates that current_state changes only on the positive
*  edge of the clock, although next_state changes as soon as the inputs change.
*/

`timescale 1 ms / 100 ps

module tb_current_state();

reg clock;
reg reset;
reg turn;
reg hazard;
reg left;

wire [1:0]KEY;
wire [1:0]SW;
assign KEY[0] = ~reset;
assign KEY[1] = left;
assign SW[0] =  hazard;
assign SW[1] = turn;

wire [1:0]NS;
wire [1:0]CS;

Lab3 u1(
    .ADC_CLK_10(clock),
    .KEY(KEY),
    .SW(SW)

);

assign NS = u1.next_state;
assign CS = u1.current_state;

always  
        #500  clock = ~clock;  // 1 period = 1 second

initial begin
    $dumpfile("tb_current_state.vcd");
    $dumpvars;
    $display("Starting simulation");
    clock <= 0;
    reset <= 0;
    turn <= 0;
    hazard <= 0;
    #100 // offset state changes so they don't occur with the clock.
    //next_state should be IDLE no matter what
    #1000 reset = 1;
    #1000 turn = 1;
    #1000 hazard = 1;

    #1000 reset <= 0;
    turn <= 0;
    hazard <= 0;

    // reset = 0. 
    // next_state always HAZARD
    #1000 hazard = 1; 
    #1000 turn = 1;

    #1000 reset <= 0;
    turn <= 0;
    hazard <= 0;

    //reset = 0, hazard = 0
    // next_state should be TURN
    #1000 turn = 1;
    // next_state should be IDLE
    #1000 turn = 0;

    #2000  $display("Simulation ended.");
    $finish;
end

initial begin
      #100 $monitor($time, " reset=%b | turn=%b | hazard=%b | next_state=%b", reset, turn, hazard, NS);
end

endmodule