`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 16:44:18
// Design Name: 
// Module Name: adr
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


module adr(
    addr,
    fetch,
    ir_addr,
    pc_addr
    );
    output  [12:0]  addr;
    input   [12:0]  ir_addr, pc_addr;
    input   fetch;
    
    assign  addr = fetch ? pz_addr : ir_addr;
    
endmodule
