module next_state_logic(
    input reset, 
    input turn, 
    input hazard, 
    output reg [1:0]next_state
);



always @(*) begin
    if(reset) next_state = IDLE; 
    else if (hazard) next_state = HAZARD; 
    else if(turn) next_state = TURN;
    else next_state = IDLE;
end

endmodule

/*

RESET | HAZARD | TURN | STATE
  1       x       x      IDLE
  0       1       x      HAZARD
  0       0       1      TURN
  0       0       0      IDLE

*/
  
