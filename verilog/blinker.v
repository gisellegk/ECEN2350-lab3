module blinker(input clock, input state, output reg [2:0] left, output reg [2:0] right);

`include "verilog/params.vh" // quartus
//`include "../verilog/params.vh" // TEST ONLY

always @(clock) begin
    if(state == TURN) begin
    // do TURN logic
    end else if(state == HAZARD) begin
    // do HAZARD logic
    end
    else begin
    // off
    end
end

endmodule