`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 16:50:06
// Design Name: 
// Module Name: machinectl
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


module machinectl(
    ena,
    fetch,
    rst,
    clk
    );
    output  ena;
    input   fetch, rst, clk;
    reg ena;
    reg state;
    
    always@(posedge clk)
        begin
            if(rst) ena <= 0;
            else
                if(fetch)   ena <= 1;
        end
endmodule
