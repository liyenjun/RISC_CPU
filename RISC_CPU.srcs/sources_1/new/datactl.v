`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 16:42:16
// Design Name: 
// Module Name: datactl
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


module datactl(
    data,
    in,
    data_ena
    );
    output  [7:0]   data;
    input   [7:0]   in;
    input   data_ena;
    
    assign  data = (data_ena) ? in : 8'bzzzz_zzzz;
endmodule
