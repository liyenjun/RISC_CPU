`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 17:44:32
// Design Name: 
// Module Name: rom
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


module rom(
    data,
    addr,
    read,
    ena
    );
    output  [7:0]   data;
    input   [7:0]   addr;
    input   read, ena;
    reg [7:0]   memory  [13'h1fff:0];
    wire    [7:0]   data;
        
    assign  data = (read&&ena) ? memory[addr] : 8'bzzzz_zzzz; 
endmodule
