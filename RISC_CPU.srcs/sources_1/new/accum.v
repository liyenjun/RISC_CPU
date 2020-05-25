`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 16:24:31
// Design Name: 
// Module Name: accum
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


module accum(
    accum,
    data,
    ena,
    clk,
    rst
    );
    output [7:0] accum;
    input [7:0] data;
    input ena, clk, rst;
    reg [7:0] accum;
    
    always@(posedge clk)
        begin
            if(rst)
                accum <= 8'b0000_0000;
            else
                if(ena) accum <= data;
        end
endmodule
