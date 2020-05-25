`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 16:11:45
// Design Name: 
// Module Name: register
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


module register(
    opc_iraddr,
    data,
    ena,
    clk,
    rst
    );
    output [15:0] opc_iraddr;
    input[7:0] data;
    input ena, clk, rst;
    reg [15:0] opc_iraddr;
    reg state;
    
    always@(posedge clk)
    begin
        if(ret)
            begin
                opc_iraddr <= 16'b0000_0000_0000_0000;
                state <= 1'b0;
            end
        else
            begin
                if(ena)
                    begin
                        casex(state)
                            1'b0:
                                begin
                                    opc_iraddr[15:8] <= data;
                                    state <= 1;
                                end
                            1'b1:
                                begin
                                    opc_iraddr[7:0] <= data;
                                    state <= 0;
                                end
                            default:
                                begin
                                    opc_iraddr[15:0] <= 16'bxxxx_xxxx_xxxx_xxxx;
                                    state <= 1'bx;
                                end
                        endcase
                    end
                else
                    state <= 1'b0;
            end
    end
endmodule
