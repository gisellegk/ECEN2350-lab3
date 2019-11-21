/* 
   ECEN 2350: Lab 2
   Module divides an inputted clock by 10 million.  
   When provided a 10 MHz clock, the output is 1 Hz. 
   Pulling reset_n to 0 will cause the clock & counter to reset to 0 on the falling edge
*/


module div10M_1(input clock,input reset_n, output reg div_clock);

reg [23:0] counter;

initial begin
     counter <= 24'b0;
     div_clock <= 1'b0;
end

always @(posedge clock)  //Detects for positive edge of clock 
begin
     if (~reset_n) begin //When reseting at a negative edge, divides the clock in half
          div_clock <= 1'b0;
          counter <= 24'b0;
     end
     else if(counter !== 4999999) begin
          // for a 10 Mhz clock, 1 tick = 100 ns. 
          //We need the state to change every half second to achieve a 1Hz signal
          // 1/2 second = 500 000 000 ns
          // 500 000 000 / 100 = 5 000 000 ticks
          // this counter counts from 0 to 4 999 999, which is 5 000 000 ticks.
          counter <= counter + 1; // keep counting up
     end
     else begin
          counter <= 0; // reset the counter
          div_clock <= ~div_clock; // flip the clock state
     end
end
endmodule
 