`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 16:46:24
// Design Name: 
// Module Name: counter
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


module counter(
    pc_addr,
    ir_addr,
    load,
    clock,
    rst
    );
    output  [12:0]  pc_addr;
    inout   [12:0]  ir_addr;
    input   load, clock, rst;
    reg [12:0]  pc_addr;
    
    always@(posedge clock or posedge rst)
        begin
            if(rst)
                pc_addr <= 13'b0_0000_0000_0000;
            else
                if(load)
                    pc_addr <= ir_addr;
                else
                    pc_addr <= pc_addr + 1;
        end
endmodule
