// iverilog -o tb_next_state_logic.out tb_next_state_logic.v ../verilog/next_state_logic.v; 
// vvp tb_next_state_logic.out > tb_next_state.txt; 
// gtkwave tb_next_state_logic.vcd -g

`timescale 1 ns / 100 ps

module tb_next_state_logic();

reg reset;
reg turn;
reg hazard;

wire [1:0]NS;

next_state_logic u1 
(
    .reset(reset),
    .turn(turn),
    .hazard(hazard),
    .next_state(NS)
);

initial begin
    $dumpfile("tb_next_state_logic.vcd");
    $dumpvars;
    $display("Starting simulation");
    reset <= 0;
    turn <= 0;
    hazard <= 0;
    
    //next_state should be IDLE no matter what
    #10 reset = 1;
    #10 turn = 1;
    #10 hazard = 1;

    #10 reset <= 0;
    turn <= 0;
    hazard <= 0;

    // reset = 0. 
    // next_state always HAZARD
    #10 hazard = 1; 
    #10 turn = 1;

    #10 reset <= 0;
    turn <= 0;
    hazard <= 0;

    //reset = 0, hazard = 0
    // next_state should be TURN
    #10 turn = 1;
    // next_state should be IDLE
    #10 turn = 0;

    #20  $display("Simulation ended.");
    $finish;
end

initial begin
      #10 $monitor($time, " reset=%b | turn=%b | hazard=%b | next_state=%b", reset, turn, hazard, NS);
end

endmodule