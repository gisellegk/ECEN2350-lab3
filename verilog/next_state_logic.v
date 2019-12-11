module next_state_logic(
    input reset,
    input current_state, 
    input turn, 
    input left, 
    input hazard, 
    output reg [1:0]next_state
);

//`include "verilog/params.vh" // quartus
`include "../verilog/params.vh" // TEST ONLY

always @(*) begin
    if(reset) begin
        next_state = IDLE;
    end else
    case(current_state)
        IDLE: begin
            if(hazard) next_state = HAZARD;
            else if(turn && left) next_state = LTURN;
            else if(turn && ~left) next_state = RTURN;
            else next_state = IDLE;
        end
        HAZARD: begin
            if(hazard) next_state = HAZARD;
            else if(turn && left) next_state = LTURN;
            else if(turn && ~left) next_state = RTURN;
            else next_state = IDLE;
        end
        LTURN: begin
            if(hazard) next_state = HAZARD;
            else if(turn && left) next_state = LTURN;
            else if(turn) next_state = RTURN;
            else next_state = IDLE;
        end
        RTURN: begin
            if(hazard) next_state = HAZARD;
            else if(turn && left) next_state = LTURN;
            else if(turn && ~left) next_state = RTURN;
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