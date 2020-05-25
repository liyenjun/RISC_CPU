`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 17:36:33
// Design Name: 
// Module Name: addr_decode
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


module addr_decode(    
    rom_sel,
    ram_sel,
    addr
    );
    output  rom_sel, ram_sel;
    input   [12:0]   addr;
    reg rom_sel, ram_sel;
    
    always@(addr)
        begin
            casex(addr)
                13'b1_1xxx_xxxx_xxxx: {rom_sel, ram_sel} <= 2'b01;
                13'b0_xxxx_xxxx_xxxx: {rom_sel, ram_sel} <= 2'b10;
                13'b1_0xxx_xxxx_xxxx: {rom_sel, ram_sel} <= 2'b10;
                default:{rom_sel, ram_sel} <= 2'b00;
            endcase
        end       
endmodule
