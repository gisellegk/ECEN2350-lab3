module next_state_logic(
    input current_state, 
    input turn, 
    input hazard, 
    output reg [1:0]next_state
);

`include "verilog/params.vh" // quartus
//`include "../verilog/params.vh" // TEST ONLY

always @(current_state) begin
    case(current_state)
        IDLE: begin
            if(hazard) next_state = HAZARD;
            else if(turn) next_state = TURN;
            else next_state = IDLE;
        end
        HAZARD: begin
            if(hazard) next_state = HAZARD;
            else if(turn) next_state = TURN;
            else next_state = IDLE;
        end
        TURN: begin
            if(hazard) next_state = HAZARD;
            else if(turn) next_state = TURN;
            else next_state = IDLE;
        end
        default: begin
        end
    endcase

end

endmodule

/*

RESET | HAZARD | TURN | STATE
  1       x       x      IDLE
  0       1       x      HAZARD
  0       0       1      TURN
  0       0       0      IDLE

*/
  
/*always @(*) begin
    if(reset) next_state = IDLE; 
    else if (hazard) next_state = HAZARD; 
    else if(turn) next_state = TURN;
    else next_state = IDLE;
end*/