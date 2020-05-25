`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 17:41:02
// Design Name: 
// Module Name: ram
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


module ram(
    data, 
    addr, 
    ena, 
    read,
    write
    );
    inout   [7:0]   data;
    input   [9:0]   addr;
    input   ena, read, write;
    reg [7:0]   ram [10'h3ff:0];
    
    assign data = (read && ena) ? ram[addr] : 8'hzz;
    
    always@(posedge write)
        begin
            ram[addr] <= data;
        end    
endmodule
