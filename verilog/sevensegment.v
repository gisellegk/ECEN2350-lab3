module sevensegment(
    input       [3:0]   NUM,
    input               NEGATIVE,
    input               DECIMAL,
    input               DISABLE,

    //////////// SEG7 //////////
	output		     [7:0]		SEVENSEG_OUT
);

reg [7:0] OUTPUT;

always @ (NUM[3:0], NEGATIVE, DECIMAL, DISABLE)
    begin
        if(DISABLE)
            OUTPUT[7:0] = 8'b11111111;
        else 
        begin
            OUTPUT[7] = ~DECIMAL;
            if(NEGATIVE)
                OUTPUT[6:0] = 7'b0111111;
            else
                case(NUM[3:0])
                    8'h0:
                        OUTPUT[6:0] = 7'b1000000;
                    8'h1: 
                        OUTPUT[6:0] = 7'b1111001;
                    8'h2:
                        OUTPUT[6:0] = 7'b0100100;
                    8'h3:
                        OUTPUT[6:0] = 7'b0110000;
                    8'h4:
                        OUTPUT[6:0] = 7'b0011001;
                    8'h5:
                        OUTPUT[6:0] = 7'b0010010;
                    8'h6:
                        OUTPUT[6:0] = 7'b0000010;
                    8'h7:
                        OUTPUT[6:0] = 7'b1111000;
                    8'h8:
                        OUTPUT[6:0] = 7'b0000000;
                    8'h9:
                        OUTPUT[6:0] = 7'b0011000;
                    8'ha:
                        OUTPUT[6:0] = 7'b0001000;
                    8'hb:
                        OUTPUT[6:0] = 7'b0000011;
                    8'hc:
                        OUTPUT[6:0] = 7'b1000110;
                    8'hd:
                        OUTPUT[6:0] = 7'b0100001;
                    8'he:
                        OUTPUT[6:0] = 7'b0000110;
                    8'hf:
                        OUTPUT[6:0] = 7'b0001110;

                    default: OUTPUT[6:0] = 7'b0100111; // this is like a lower case c. should never run, but just in case it does, it will do something.
                endcase
        end
    end

    assign SEVENSEG_OUT = OUTPUT;
    
endmodule