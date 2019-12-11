//iverilog -o tb_lights.out tb_lights.v ../verilog/*.v ../Lab3.v;
// vvp tb_lights.out > tb_next_state.txt; 
// gtkwave tb_lights.vcd -g

/*
*  this testbench demonstrates the behavior of the back lights 
*  based on the current state.
*/

`timescale 1 ms / 100 ps

module tb_lights();

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
    $dumpfile("tb_lights.vcd");
    $dumpvars;
    $display("Starting simulation");
    clock <= 0;
    reset <= 0;
    turn <= 0;
    hazard <= 0;
    left <= 0;

    #1000     
    reset = 1; // IDLE for 5 sec
    #5000 
    
    reset <= 0; 
    #1000 
    hazard = 1; // HAZARD for 18 sec
    #18000 

    hazard <= 0;
    #1000 
    turn <= 1;
    left <= 1; // TURN LEFT for 18 sec
    #18000 
    
    left <= 0; // TURN LEFT for 18 sec
    #18000 

    #2000  $display("Simulation ended.");
    $finish;
end

endmodule