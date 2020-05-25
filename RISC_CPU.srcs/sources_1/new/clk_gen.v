`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 15:55:16
// Design Name: 
// Module Name: clk_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_gen(
   clk,
   reset,
   fetch,
   alu_ena
    );
    input clk, reset;
    output fetch, alu_ena;
    wire clk, reset;
    reg fetch, alu_ena;
    reg[7:0] state;
    
    parameter   S1 = 8'b0000_0001,
                S2 = 8'b0000_0010,
                S3 = 8'b0000_0100,
                S4 = 8'b0000_1000,
                S5 = 8'b0001_0000,
                S6 = 8'b0010_0000,
                S7 = 8'b0100_0000,
                S8 = 8'b1000_0000,
                idle = 8'b0000_0000;
    
    always@(negedge clk)
        if(reset)
            begin
                fetch <= 0;
                alu_ena <= 0;
                state <= idle;
             end
         else
            begin
                case(state)
                    S1:
                        begin
                            alu_ena <= 1;
                            state <= S2;
                        end
                    S2:
                        begin
                            alu_ena <= 0;
                            state <= S3;
                        end
                    S3:
                        begin
                            fetch <= 1;
                            state <= S4;
                        end
                    S4: state <= S5;                                                    
                    S5: state <= S6;
                    S6: state <= S7;
                    S7:
                        begin
                            fetch <= 0;
                            state <= S8;
                        end
                    S8: state <= S1;                                                 
                    idle: state <= S1;
                    default: state <= S1;
                endcase
            end
endmodule
