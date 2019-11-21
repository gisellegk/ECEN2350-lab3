module next_state_logic(
    input current_state,
    input reset, 
    input turn, 
    input hazard, 
    output reg [1:0]next_state
);

always @(current_state) begin
    if(current_state == IDLE) begin
        if(reset) go back to idle
        if (turn) go to turn state
        if(hazard) go to hazard state
    end
        IDLE: 
        HAZARD:
        TURN:
        default:
    endcase

end

endmodule

/*    // some logic here
    case(state)
    if(state == idle) begin
        
    end
    if(state == turn) begin
        if(reset) go to idle
        if (turn) go to turn state
        if(hazard) go to hazard state
    end
    if(state == hazard) begin
        if(reset) go to idle
        //ignore turn
        if(hazard) go to hazard state
    end
    
    state_reg = next_state;*/